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

class Date
  def to_utc_time
    dest = new_offset
    # Convert a fraction of a day to a number of microseconds
    usec = (dest.sec_fraction * 60 * 60 * 24 * (10**6)).to_i
    Time.send(:utc, dest.year, dest.month, dest.day, dest.hour, dest.min, dest.sec, usec)
  end
end

module FlexiScale
  
  def self.attrs_to_hash(*list)
    result = {}
    object = list.shift
    list.each { |attribute| result[attribute] = object.__send__(attribute) }
    result
  end
  
  class OperatingSystemImage
    def to_handy_hash
      { :fxs_id => self.operating_system_image_id, 
        :name   => self.operating_system_image_name }
    end
  end

  class Disk
    def to_handy_hash
      ::FlexiScale::attrs_to_hash(self, :capacity, :locked, :package_id, :server_id, :usage).merge(
        :fxs_id => self.disk_id,
        :name   => self.disk_name
      )
    end
  end

  class NetworkInterface
    def to_handy_hash
      ::FlexiScale::attrs_to_hash(self, :server_id, :vlan_id, :mac_address).merge(
        :fxs_id => self.network_interface_id
      )
    end
  end

  class IpBlock
    def to_handy_hash
      ::FlexiScale::attrs_to_hash(self, :customer_vlan_id, :end_ip, :start_ip).merge(
        :fxs_id => self.ip_block_id,
        :type   => self.block_type
      )
    end
  end

  class Firewall
    def to_handy_hash
      ::FlexiScale::attrs_to_hash(self, :ip_address, :default_policy).merge(
        :fxs_id => self.firewall_id
      )
    end
  end

  class FirewallTemplate
    def to_handy_hash
      { :fxs_id         => self.firewall_template_id,
        :name           => self.template_name,
        :default_policy => self.default_policy }
    end
  end

  class FirewallRule
    def to_handy_hash
      ::FlexiScale::attrs_to_hash(self, :action, :destination_port, :direction, :firewall_id, 
                                        :icmp_parameter_id, :ip_address, :ip_address_mask, 
                                        :firewall_protocol_id, :sequence_no,  
                                        :source_port, :jump_to).merge(
        :fxs_id => self.firewall_rule_id,
        :name   => self.rule_name
      )
    end
  end

  class FirewallTemplateRule
    def to_handy_hash
      ::FlexiScale::attrs_to_hash(self, :action, :destination_port, :direction, :firewall_protocol_id,
                                        :firewall_template_id, :icmp_parameter_id, :ip_address,
                                        :ip_address_mask, :jump_to, :sequence_no, :source_port).merge(
        :fxs_id => self.firewall_template_rule_id,
        :name   => self.rule_name
      )
    end
  end

  class IcmpProtocol
    def to_handy_hash
      { :fxs_id      => self.icmp_protocol_id,
        :description => self.description }
    end
  end

  class FirewallProtocol
    def to_handy_hash
      { :fxs_id => self.firewall_protocol_id,
        :name   => self.name }
    end
  end

  class Vlan
    def to_handy_hash
      { :fxs_id => self.vlan_id,
        :name   => self.vlan_name }
    end
  end

  class Server
    STATUS_IN_WORDS = { '1' => 'error',
                        '2' => 'running',
                        '3' => 'starting',
                        '4' => 'stopping',
                        '5' => 'stopped' }
    def to_handy_hash
      ::FlexiScale::attrs_to_hash(self, :disk_capacity, :disks, :initial_password, :ip_addresses, 
                                        :memory, :modified, :network_interfaces, :package_id, 
                                        :processors, :status, :uptime ).merge(
        :fxs_id     => self.server_id,
        :name       => self.server_name,
        :fxs_status => self.status,
        :status     => STATUS_IN_WORDS[self.status],
        :image_id   => self.operating_system_image.operating_system_image_id,
        :image_name => self.operating_system_image.operating_system_image_name
      )
    end
  end

  class Job
    # TODO : find statuses name
    STATUS_IN_WORDS = { }
    def to_handy_hash
      ::FlexiScale::attrs_to_hash(self, :type_id, :description, :parent_job,
                                        :notes ).merge(
        :fxs_id      => self.job_id,
        :fxs_status  => self.status,
        :status      => STATUS_IN_WORDS[self.status],
        :started_at  => self.started.to_utc_time,
        :finished_at => self.finished.to_utc_time
      )
    end
  end

  class Package
    def to_handy_hash
      { :fxs_id => self.package_id,
        :name   => self.package_name }
    end
  end

  class DebitItem
    def to_handy_hash
      ::FlexiScale::attrs_to_hash( self, :debit_id, :item_type, :type_id, :item_value, :item_cost, 
                                         :description ).merge(
        :fxs_id    => self.debit_item_id,
        :timestamp => Time.at(self.timestamp.to_i)
      )
    end
  end

  class Debit
    def to_handy_hash
      ::FlexiScale::attrs_to_hash( self, :creation_time, :item_count, :item_cost ).merge(
        :fxs_id        => :debit_id,
        :creation_time => Time.at(self.creation_time.to_i)
      )
    end
  end

  class Credit
    def to_handy_hash
      { :fxs_id        => self.credit_id,
        :date          => self.credit_date,
        :amount        => self.credit_amount,
        :unused_credit => self.unused_credit
      }
    end
  end

  class CreditDebit
    def to_handy_hash
      ::FlexiScale::attrs_to_hash( self, :credit_id, :debit_id, :amount ).merge(
        :fs => self.credit_debit_id
      )
    end
  end

  %w{ ArrayOf_xsd_int ArrayOf_xsd_string ArrayOfServer ArrayOfCredit
      ArrayOfOperatingSystemImage ArrayOfFirewall ArrayOfFirewallTemplate 
      ArrayOfFirewallRule ArrayOfFirewallTemplateRule ArrayOfIcmpProtocol 
      ArrayOfFirewallProtocol ArrayOfIpBlock ArrayOfVlan ArrayOfNetworkInterface
      ArrayOfDisk ArrayOfJob ArrayOfPackage ArrayOfDebitItem ArrayOfDebit }.each do |klass_name|
        eval <<-EOF
          class #{klass_name}
            def to_handy_hash
              map { |item| item.to_handy_hash }
            end
          end
        EOF
      end
      
end
