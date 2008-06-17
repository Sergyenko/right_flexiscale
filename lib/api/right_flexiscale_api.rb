#
# Copyright (c) 2008 RightScale Inc
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

require 'Flexiscale APIDriver'
require 'Flexiscale APIAddons'
require 'logger'

module RightFlexiscale
  
  class FxsError < RuntimeError 
  end
  
  class FxsBenchmarkingBlock #:nodoc:
    attr_accessor :service
    def initialize
      # Benchmark::Tms instance for service (Ec2, S3, or SQS) access benchmarking.
      @service = Benchmark::Tms.new()
    end
  end

  # = RightFlexiscale::Api -- RightScale Flexiscale interface
  # The RightFlexiscale::Api class provides a complete interface to Flexiscale's
  # Web service.
  # For explanations of the semantics
  # of each call, please refer to Flexiscale's documentation at
  # http://api.flexiscale.com
  #
  # Examples:
  #
  #  flexiscale = RightFlexiscale::Api(username, password)
  #  
  #  # get servers list
  #  servers = flexiscale.list_servers
  #  
  #  # OS images
  #  images = flexiscale.list_operating_system_images
  #  
  #  # create a new server
  #  image     = flexiscale.list_operating_system_images.first
  #  package   = flexiscale.list_packages.first
  #  vlan      = flexiscale.list_vlans.first
  #  server_id = flexiscale.create_server('my_awesome_server', package[:fxs_id], 1, 1024, 20, image[:fxs_id], vlan[:fxs_id])
  #  
  #  # launch a server
  #  job_id = flexiscale.start_server('my_awesome_server')
  #  
  #  # reboot
  #  job_id = flexiscale.reboot_server('my_awesome_server')
  #
  #  # stop and destroy server
  #  job_id = flexiscale.stop_server('my_awesome_server')
  #  if flexiscale.wait_for_jobs(job_id)
  #    flexiscale.destroy_server('my_awesome_server')
  #  end
  #  
  # Error handling: all operations raise an RightFlexiscale::FxsError in case
  # of problems.
  #
  # ------------------
  # Known problems:
  # 
  #   1. list_firewall_templates dies if any list value is defined (ask Flexiscale)
  #   2. find out job statuses text names (ask Flexiscale)
  #
  class Api
    attr_reader :params
    attr_reader :logged_in
    attr_reader :username
    attr_reader :password
    attr_reader :api
    attr_reader :last_raw_response

    @@bench = FxsBenchmarkingBlock.new
    def self.bench_service
      @@bench.service
    end
    
    FLEXISCALE_WSDL      = "https://api.flexiscale.com/current/Flexiscale.wsdl"

    SERVER_STOP_SHUTDOWN = 1
    SERVER_STOP_POWEROFF = 2
    
    DEFAULT_HTTP_CONNECT_TIMEOUT = 60
    DEFAULT_HTTP_RECEIVE_TIMEOUT = 300

    # Create a new interface to Flexiscale API.
    # 
    #  params:
    #   :raw_response - return SOAP objects as is
    #   :logger       - logger object (STDOUT is used by default)
    #   :skip_logging - log nothing 
    #
    #  flexiscale = RightFlexiscale::Api.new(username, password)
    #  flexiscale.list_packages #=> [{:fxs_id => 40175,
    #                                 :name   => "rightscale"}]
    #
    #  flexiscale = RightFlexiscale::Api.new(username, password, :raw_response=>true) #=> 
    #  flexiscale.list_packages #=> [#<FlexiScale::Package:0xb78a1904
    #                                  @package_id   = 40175,
    #                                  @package_name = "rightscale">]
    #
    def initialize(username, password, params={})
      @username  = username || ENV['FLEXISCALE_USERNAME']
      @password  = password || ENV['FLEXISCALE_PASSWORD']
      @params    = params
      # initializationvars
      @params[:logger] ||= Logger.new(STDOUT)
      @logged_in = false
      @last_raw_response = nil
      # create a new interface
      @api = ::FlexiScale::FlexiScale.new
      @api.wiredump_dev = STDERR if $DEBUG
      # timeouts: 1 min for connection establishment and
      # 5 min for wait_for_jobs
      @api.options["protocol.http.connect_timeout"] = DEFAULT_HTTP_CONNECT_TIMEOUT
      @api.options["protocol.http.receive_timeout"] = DEFAULT_HTTP_RECEIVE_TIMEOUT
#      @api.options["protocol.http.send_timeout"]
    end 

    def log(message, level=:info) # :nodoc:
      unless @params[:skip_logging]
        message = "#{self.class.name}: #{message}"
        @params[:logger].__send__(level, message)
      end
    end
    
    def log_error(e, klass=nil, level=:error) # :nodoc:
      unless @params[:skip_logging]
        log_trace = log_trace && ("\n"+e.backtrace.join("\n"))
        message = "#{(klass || e.class).name}: #{e.message}#{log_trace}"
        @params[:logger].__send__(level, message)
      end
    end
    
    def internal_login(username=nil, password=nil) # :nodoc:
      @username  = username if username
      @password  = password if password
      @logged_in = false
      @api.login(@username, @password)
      @logged_in = true
    end  
    
    # Request Flexiscale. 
    # Performs a retry on login problems (timeouts etc).
    #  params:
    #    :block    - block of code (is used when retry) 
    #    :no_retry - do not retry on error
    #    :no_login - do not auto login
    #
    def perform_request(params={}, &block) # :nodoc:
      result = nil
      # block is passed as param on retry
      block ||= params[:block]
      # perform a request
      begin
        # login if required
        if !params[:no_login] && !@logged_in
          @@bench.service.add! do
            internal_login 
          end
        end
        # call the block of code is passed
        if block
          @@bench.service.add! do
            result = @last_raw_response = block.call
          end
        end
      rescue Exception => e
        # Repeat the request if we run into 'not logged in' message
        # (This may happen when @logged_in==true and timeouts etc...
        #  Actually I did not run into this but ...)
        if e.message[/Your credentials are unsuitable or missing/] && !params[:no_retry] 
          log "Unsuitable credentials: will try to relogin and rerequest..."
          @logged_in = false
          result     = perform_request(:no_retry=>true, :block=>block)
        else
          # Check InvalidCredentials case
          @logged_in = false if e.message[/InvalidCredentials/]
          # Reraise an error ...
          if e.is_a?(SOAP::FaultError)
            # ... as RightFlexiscale::FxsError
            log_error(e, FxsError)
            raise FxsError.new(e.message)
          else
            # ... as is
            log_error(e)
            raise e
          end
        end
      end
      # convert a result to a handy format
      if result.class.name[/^FlexiScale::/] && !@params[:raw_response]
        result = result.to_handy_hash
      end
      result
    end

    #----------------------------------------
    # FLEXISCALE_API
    #----------------------------------------

    #----------------------------------------
    # Miscellaneous
    #----------------------------------------

    # Loging into the API. Returns +true+ on success.
    # 
    # https://api.flexiscale.com/current/doc/login.html
    def login(username=nil, password=nil)
      @logged_in = false
      @username  = username if username
      @password  = password if password
      # without a block perform_request just logs in
      perform_request(:no_retry=>true)
      true
    end  

    # Logout of the API.
    # 
    # https://api.flexiscale.com/current/doc/login.html
    def logout
      @logged_in = false
      perform_request(:no_login=>true) do
        @api.logout
      end
    end  

    # List packages. Returns an array of packages.
    # +list+ is an array of ids.
    #
    #  flexiscale.list_packages #=> 
    #       [{:fxs_id => 40175, 
    #         :name   => "rightscale"}]
    #  
    # https://api.flexiscale.com/current/doc/list_packages.html
    def list_packages(*list)
      perform_request do
        @api.listPackages(list.flatten)
      end
    end

    #----------------------------------------
    # Servers
    #----------------------------------------

    # List servers. Returns an array of servers.
    # +list+ is an array of servers names.
    # 
    #  flexiscale.list_servers #=>
    #       [{:memory             => 512,
    #         :processors         => 1,
    #         :fxs_id             => 1343,
    #         :image_id           => 27,
    #         :image_name         => "Ubuntu 8.04 LTS", 
    #         :initial_password   => "0000000000000000\n",
    #         :name               => "my_awesome_server",
    #         :uptime             => 0,
    #         :modified           => false,
    #         :status             => "stopped"
    #         :fxs_status         => "5",
    #         :package_id         => 40175,
    #         :disks              => [2285],
    #         :disk_capacity      => 20480,
    #         :ip_addresses       => ["92.60.121.68"],
    #         :network_interfaces => [778]}, ... ]
    # 
    # https://api.flexiscale.com/current/doc/list_servers.html
    def list_servers(*list)
      perform_request do
        @api.listServers(list.flatten)
      end
    end

    # Create a server. Returns a new +server_id+. 
    # (+Memory+ in MB, +disk_capacity+ in GB)
    # 
    #  flexiscale.create_server('my_awesome_server', 40175, 1, 512, 20, 27, 1552) #=> 1343
    #
    # https://api.flexiscale.com/current/doc/create_server.html
    def create_server(server_name, package_id, processors, memory, disk_capacity, operating_system_image_id, vlan_id)
      image  = FlexiScale::OperatingSystemImage.new(operating_system_image_id)
      server = FlexiScale::Server.new(nil, server_name, nil, package_id, processors, memory, image, disk_capacity)
      vlan   = FlexiScale::Vlan.new(vlan_id)
      perform_request do
        @api.createServer(server, vlan)
      end
    end

    # Modify server params. Returns a modified server data.
    # Note: a stop_start_server request will need to be sent after the modification 
    # have been made which will reboot the server and apply the changes
    #
    #  flexiscale.modify_server(1343, 1, 1024) #=>
    #        {:memory             => 1024,
    #         :processors         => 1,
    #         :fxs_id             => 1343,
    #         :image_id           => 27,
    #         :image_name         => "Ubuntu 8.04 LTS", 
    #         :initial_password   => "0000000000000000\n",
    #         :name               => "my_awesome_server",
    #         :uptime             => 0,
    #         :modified           => false,
    #         :status             => "stopped"
    #         :fxs_status         => "5",
    #         :package_id         => 40175,
    #         :disks              => [2285],
    #         :disk_capacity      => 20480,
    #         :ip_addresses       => ["92.60.121.68"],
    #         :network_interfaces => [778]}
    #         
    # https://api.flexiscale.com/current/doc/modify_server.html
    def modify_server(server_id, processors, memory)
      server = FlexiScale::Server.new(server_id, nil, nil, nil, processors, memory)
      perform_request do
        @api.modifyServer(server)
      end
    end

    # Start a server.
    # The response is returned as a integer which is the job number  of the request,
    # this can be looked up using wait_for_jobs and list_jobs.
    # 
    #  flexiscale.start_server('my_awesome_server') #=> 11034
    # 
    # https://api.flexiscale.com/current/doc/start_server.html
    def start_server(server_name, notes='')
      perform_request do
        @api.startServer(server_name, notes)
      end
    end

    # Reboot a server.
    # The response is returned as a integer which is the job number  of the request,
    # this can be looked up using wait_for_jobs and list_jobs.
    #
    #  flexiscale.reboot_server('my_awesome_server') #=> 11035
    #  
    # https://api.flexiscale.com/current/doc/reboot_server.html
    def reboot_server(server_name, notes='')
      perform_request do
        @api.rebootServer(server_name, notes)
      end
    end

    # Stop a server. 
    # The response is returned as a integer which is the job number  of the request,
    # this can be looked up using wait_for_jobs and list_jobs.
    # 
    #  - method = (:shutdown || RightFlexiscale::SERVER_STOP_SHUTDOWN) || 
    #             (:poweroff || RightFlexiscale::SERVER_STOP_POWEROFF)
    #             
    #  flexiscale.stop_server('my_awesome_server') #=> 11036
    #  
    # https://api.flexiscale.com/current/doc/stop_server.html
    def stop_server(server_name, method=:shutdown, notes='')
      perform_request do
        case method.to_s
        when 'shutdown', SERVER_STOP_SHUTDOWN.to_s then @api.stopServer(server_name, SERVER_STOP_SHUTDOWN, notes)
        when 'poweroff', SERVER_STOP_POWEROFF.to_s then @api.stopServer(server_name, SERVER_STOP_POWEROFF, notes)
        end
      end
    end

    # Stop and Restart an existing server.
    # The response is returned as a integer which is the job number of the request, 
    # this can be looked up using wait_for_jobs and list_jobs.
    #
    #  flexiscale.stop_start_server('my_awesome_server') #=> 11037
    #  
    # https://api.flexiscale.com/current/doc/stop_start_server.html
    def stop_start_server(server_name, notes='')
      perform_request do
        @api.stopStartServer(server_name, notes)
      end
    end

    # Destroy a server. Returns +true+ if OK.
    #
    #  flexiscale.destroy_server('my_awesome_server') #=> true
    #  
    # https://api.flexiscale.com/current/doc/delete_server.html
    def destroy_server(server_name)
      perform_request do
        @api.destroyServer(server_name)
      end
      true
    end

    #----------------------------------------
    # Disk Management
    #----------------------------------------

    # List disks. Returns an array of disks.
    # +list+ is an array of ids.
    #
    #  flexiscale.list_disks #=>
    #        [{:capacity   => 20,
    #          :server_id  => 1322,
    #          :usage      => 0.03,
    #          :name       => "Server 1322 Operating System",
    #          :locked     => 0,
    #          :package_id => 40175,
    #          :fxs_id     => 2262}, ... ]
    #
    # https://api.flexiscale.com/current/doc/list_disks.html
    def list_disks(*list)
      perform_request do
        @api.listDisks(list.flatten)
      end
    end

    #----------------------------------------
    # Jobs
    #----------------------------------------

    # List jobs. Returns an array of jobs.
    # +list+ is an array of ids.
    #
    #  flexiscale.list_jobs #=>
    #        [{:fxs_status  => 2,
    #          :status      => nil,
    #          :started_at  => Fri Jun 13 13:21:27 UTC 2008,
    #          :description => "start_virtual_server",
    #          :finished_at => Fri Jun 13 13:23:42 UTC 2008,
    #          :type_id     => 1322,
    #          :notes       => "kd-from-home-via-api",
    #          :fxs_id      => 10928,
    #          :parent_job  => 0}, ... ]
    #
    # https://api.flexiscale.com/current/doc/list_jobs.html
    def list_jobs(*list)
      perform_request do
        @api.list_jobs(list.flatten)
      end
    end

    # List running jobs. Returns an array of running jobs.
    # +list+ is an array of ids.
    # 
    #  flexiscale.list_running_jobs #=> []
    #
    # https://api.flexiscale.com/current/doc/list_running_jobs.html
    def list_running_jobs
      perform_request do
        @api.listRunningJobs
      end
    end

    # Wait for jobs completion.
    # The command returns a boolean value, if +true+ all jobs have been completed
    # successfully, if +false+ one or more jobs failed.
    # +list+ is an array of ids.
    #
    #  flexiscale.wait_for_jobs(1132, 1133) #=> true
    #  
    # For a long wait tasks you may need to increase
    # @api.options["protocol.http.receive_timeout"]. The default value is 
    # DEFAULT_HTTP_RECEIVE_TIMEOUT
    #  
    # https://api.flexiscale.com/current/doc/wait_for_jobs.html
    def wait_for_jobs(*list)
      perform_request do
        @api.wait_for_jobs(list.flatten)
      end
    end

    # List a filtered jobs. Returns an array of jobs.
    #  - order_by:  :+status+ || :job_id || :type_id || :started || :finished || :description || :parent_job
    #  - direction: :+asc+ || :desc
    #  
    #  flexiscale.filter(100, :status, :desc ) #=>
    #        [{:fxs_status  => 2,
    #          :status      => nil,
    #          :started_at  => Fri Jun 13 13:21:27 UTC 2008,
    #          :description => "start_virtual_server",
    #          :finished_at => Fri Jun 13 13:23:42 UTC 2008,
    #          :type_id     => 1322,
    #          :notes       => "kd-from-home-via-api",
    #          :fxs_id      => 10928,
    #          :parent_job  => 0}, ... ]
    #  
    # https://api.flexiscale.com/current/doc/filter_jobs.html
    def filter_jobs(limit=50, order_by=:status, direction=:asc)
      perform_request do
        @api.filterJobs(limit, order_by.to_s, direction.to_s.upcase)
      end
    end

    #----------------------------------------
    # Operating Systems
    #----------------------------------------

    # List available operating system images.
    #  
    #  flexiscale.list_operating_system_images #=>
    #        [{:fxs_id=>1,  :name=>"Centos 5"},
    #         {:fxs_id=>3,  :name=>"Centos 4"},
    #         {:fxs_id=>4,  :name=>"Windows Server 2003 Standard"},
    #         {:fxs_id=>6,  :name=>"Debian 4.0 (Etch)"},
    #         {:fxs_id=>15, :name=>"Centos 5 64 Bit"},
    #         {:fxs_id=>16, :name=>"Ubuntu 6.06 LTS"},
    #         {:fxs_id=>17, :name=>"Windows Server 2003 Standard 64 Bit"},
    #         {:fxs_id=>18, :name=>"Debian 4.0 64 Bit (Etch)"},
    #         {:fxs_id=>27, :name=>"Ubuntu 8.04 LTS"}]
    #         
    # https://api.flexiscale.com/current/doc/list_operating_system_images.html
    def list_operating_system_images
      perform_request do
        @api.listOperatingSystemImages
      end
    end

    #----------------------------------------
    # Network Management
    #----------------------------------------

    # List network interfaces. Returns an array of nics.
    # +list+ is an array of ids.
    #
    #  flexiscale.list_network_interfaces #=>
    #        [{:server_id   => 1322,
    #          :fxs_id      => 749,
    #          :vlan_id     => 552,
    #          :mac_address => "00:0f:4b:22:cb:0c"}, ... ]
    #      
    # https://api.flexiscale.com/current/doc/list_nics.html
    def list_network_interfaces(*list)
      perform_request do
        @api.listNetworkInterfaces(list.flatten)
      end
    end

    # List vlans. Returns an array of vlans.
    # +list+ is an array of ids.
    # 
    #  flexiscale.list_vlans #=>
    #        [{:fxs_id => 552, 
    #          :name   => "Cust15608VLAN1"}]
    #         
    # https://api.flexiscale.com/current/doc/list_servers.html
    def list_vlans(*list)
      perform_request do
        @api.listVlans(list.flatten)
      end
    end

    # List IpBlocks. Returns an array of ip_blocks.
    # +list+ is an array of ids.
    # 
    #  flexiscale.list_ip_blocks #=>
    #        [{:type             => 29,
    #          :end_ip           => "92.60.120.70",
    #          :fxs_id           => 404,
    #          :customer_vlan_id => 552,
    #          :start_ip         => "92.60.120.60"}]
    #  
    # https://api.flexiscale.com/current/doc/list_ip_blocks.html
    def list_ip_blocks(*list)
      perform_request do
        @api.listIpBlocks(list.flatten)
      end
    end

    #----------------------------------------
    # Billing Management  
    #----------------------------------------

    # List debit items.
    #  - item_type: :virtual_server || :vlan || :disk_space
    #  
    #  flexiscale.list_debit_items(:virtual_server, 1322) #=>
    #        [{:description => "1 Hour of uptime for server kd test 1",
    #          :type_id     => 1322,
    #          :item_value  => 1.0,
    #          :item_cost   => 0.05,
    #          :fxs_id      => 738858,
    #          :debit_id    => 415192,
    #          :timestamp   => Fri Jun 13 16:45:04 +0400 2008,
    #          :item_type   => "virtual_server"}]
    #  
    # https://api.flexiscale.com/current/doc/list_debit_items.html
    def list_debit_items(item_type, type_id, start_date=nil, end_date=nil)
      perform_request do
        @api.listDebitItems(item_type.to_s, type_id, 
                            start_date && start_date.to_i, end_date && end_date.to_i)
      end
    end

    # List debits.
    #  
    # https://api.flexiscale.com/current/doc/list_debits.html
    def list_debits(start_date=nil, end_date=nil)
      perform_request do
        @api.listDebits(start_date && start_date.to_i, end_date && end_date.to_i)
      end
    end

    # List credits.
    #  
    # https://api.flexiscale.com/current/doc/list_credits.html
    def list_credits(start_date=nil, end_date=nil)
      perform_request do
        @api.listCredits(start_date && start_date.to_i, end_date && end_date.to_i)
      end
    end

    #----------------------------------------
    # Firewalls (flexiscale beta)
    #----------------------------------------

    # List firewalls.
    #
    # https://api.flexiscale.com/current/doc/list_firewalls.html
    def list_firewalls(*list)
      perform_request do
        @api.listFirewalls(list.flatten)
      end
    end

    # List firewall rulles.
    #  -direction: nil || :in || :out
    #
    # https://api.flexiscale.com/current/doc/list_firewall_rules.html
    def list_firewall_rules(firewall_id, direction=nil)
      perform_request do
        @api.listFirewallRules(firewall_id, direction && direction.to_s.upcase)
      end
    end

    # List firewall protocols.
    #
    #  flexiscale.list_firewall_protocols #=>
    #        [{:fxs_id=>0,   :name=>"Any"},
    #         {:fxs_id=>6,   :name=>"TCP"},
    #         {:fxs_id=>17,  :name=>"UDP"},
    #         {:fxs_id=>1,   :name=>"ICMP"},
    #         {:fxs_id=>41,  :name=>"GRE"},
    #         {:fxs_id=>50,  :name=>"IPSEC-ESP"},
    #         {:fxs_id=>51,  :name=>"IPSEC-AH"},
    #         {:fxs_id=>115, :name=>"L2TP"}]  
    #
    # https://api.flexiscale.com/current/doc/list_firewall_protocols.html
    def list_firewall_protocols
      perform_request do
        @api.listFirewallProtocols
      end
    end

    # List ICMP protocols.
    #
    #  flexiscale.list_icmp_protocols #=>
    #        [{:fxs_id=>0,  :description=>"Echo Reply"},
    #         {:fxs_id=>8,  :description=>"Echo"},
    #         {:fxs_id=>3,  :description=>"Destination Unreachable"},
    #         {:fxs_id=>4,  :description=>"Source Quench"},
    #         {:fxs_id=>5,  :description=>"Redirect"},
    #         {:fxs_id=>6,  :description=>"Alternate Host Address"},
    #         {:fxs_id=>9,  :description=>"Router Advertisement"},
    #         {:fxs_id=>10, :description=>"Router Solicitation"},
    #         {:fxs_id=>11, :description=>"Time Exceeded"},
    #         {:fxs_id=>12, :description=>"Parameter Problem"},
    #         {:fxs_id=>13, :description=>"Timestamp"},
    #         {:fxs_id=>14, :description=>"Timestamp Reply"},
    #         {:fxs_id=>15, :description=>"Information Request"},
    #         {:fxs_id=>16, :description=>"Information Reply"},
    #         {:fxs_id=>17, :description=>"Address Mask Request"},
    #         {:fxs_id=>18, :description=>"Address Mask Reply"}]
    #
    # https://api.flexiscale.com/current/doc/list_icmp_protocols.html
    def list_icmp_protocols
      perform_request do
        @api.listIcmpProtocols
      end
    end

    # List firewall templates.
    # (+list+ DOES NOT WORK)
    #
    #  flexiscale.list_firewall_templates #=>
    #        [{:fxs_id=>1, :name=>"Linux Web Server",   :default_policy=>"REJECT"},
    #         {:fxs_id=>2, :name=>"Windows Web Server", :default_policy=>"REJECT"},
    #         {:fxs_id=>3, :name=>"Linux Email Server", :default_policy=>"REJECT"}]
    #
    # https://api.flexiscale.com/current/doc/list_firewall_templates.html
    def list_firewall_templates(*list)
      perform_request do
        @api.listFirewallTemplates(list.flatten)
      end
    end

    # List firewall template rules.
    #  - direction: nil || :in || :out
    #
    # https://api.flexiscale.com/current/doc/list_firewall_template_rules.html
    def list_firewall_template_rules(firewall_template_id, direction=nil)
      perform_request do
        @api.listFirewallTemplateRules(firewall_template_id, direction && direction.to_s.upcase)
      end
    end

  end
  
end
