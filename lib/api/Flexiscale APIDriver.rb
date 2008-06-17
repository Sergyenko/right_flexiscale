require 'Flexiscale API.rb'
require 'Flexiscale APIMappingRegistry.rb'
require 'soap/rpc/driver'

module FlexiScale

class FlexiScale < ::SOAP::RPC::Driver
  DefaultEndpointUrl = "https://api.flexiscale.com/0.5/index.php"
  NsApiFlexiscaleCom = "http://api.flexiscale.com"

  Methods = [
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListServers"),
      "http://api.flexiscale.com",
      "listServers",
      [ ["in", "list", ["FlexiScale::ArrayOf_xsd_string", "http://api.flexiscale.com", "ArrayOf_xsd_string"]],
        ["retval", "ListServersReturn", ["FlexiScale::ArrayOfServer", "http://api.flexiscale.com", "ArrayOfServer"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListJobs"),
      "http://api.flexiscale.com",
      "listJobs",
      [ ["in", "list", ["FlexiScale::ArrayOf_xsd_int", "http://api.flexiscale.com", "ArrayOf_xsd_int"]],
        ["retval", "ListJobsReturn", ["FlexiScale::ArrayOfJob", "http://api.flexiscale.com", "ArrayOfJob"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListFirewallTemplates"),
      "http://api.flexiscale.com",
      "listFirewallTemplates",
      [ ["in", "list", ["FlexiScale::ArrayOf_xsd_int", "http://api.flexiscale.com", "ArrayOf_xsd_int"]],
        ["retval", "ListFirewallTemplatesReturn", ["FlexiScale::ArrayOfFirewallTemplate", "http://api.flexiscale.com", "ArrayOfFirewallTemplate"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListFirewallRules"),
      "http://api.flexiscale.com",
      "listFirewallRules",
      [ ["in", "firewall_id", ["::SOAP::SOAPInt"]],
        ["in", "direction", ["::SOAP::SOAPString"]],
        ["retval", "ListFirewallRulesReturn", ["FlexiScale::ArrayOfFirewallRule", "http://api.flexiscale.com", "ArrayOfFirewallRule"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListFirewallTemplateRules"),
      "http://api.flexiscale.com",
      "listFirewallTemplateRules",
      [ ["in", "firewall_template_id", ["::SOAP::SOAPInt"]],
        ["in", "direction", ["::SOAP::SOAPString"]],
        ["retval", "ListFirewallTemplateRulesReturn", ["FlexiScale::ArrayOfFirewallTemplateRule", "http://api.flexiscale.com", "ArrayOfFirewallTemplateRule"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListFirewalls"),
      "http://api.flexiscale.com",
      "listFirewalls",
      [ ["in", "list", ["FlexiScale::ArrayOf_xsd_int", "http://api.flexiscale.com", "ArrayOf_xsd_int"]],
        ["retval", "ListFirewallsReturn", ["FlexiScale::ArrayOfFirewall", "http://api.flexiscale.com", "ArrayOfFirewall"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListFirewallProtocols"),
      "http://api.flexiscale.com",
      "listFirewallProtocols",
      [ ["retval", "ListFirewallProtocolsReturn", ["FlexiScale::ArrayOfFirewallProtocol", "http://api.flexiscale.com", "ArrayOfFirewallProtocol"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListIcmpProtocols"),
      "http://api.flexiscale.com",
      "listIcmpProtocols",
      [ ["retval", "ListIcmpProtocolsReturn", ["FlexiScale::ArrayOfIcmpProtocol", "http://api.flexiscale.com", "ArrayOfIcmpProtocol"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListIpBlocks"),
      "http://api.flexiscale.com",
      "listIpBlocks",
      [ ["in", "list", ["FlexiScale::ArrayOf_xsd_int", "http://api.flexiscale.com", "ArrayOf_xsd_int"]],
        ["retval", "ListIpBlocksReturn", ["FlexiScale::ArrayOfIpBlock", "http://api.flexiscale.com", "ArrayOfIpBlock"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "FilterJobs"),
      "http://api.flexiscale.com",
      "filterJobs",
      [ ["in", "limit", ["::SOAP::SOAPInt"]],
        ["in", "order_by", ["::SOAP::SOAPString"]],
        ["in", "direction", ["::SOAP::SOAPString"]],
        ["retval", "ListJobsReturn", ["FlexiScale::ArrayOfJob", "http://api.flexiscale.com", "ArrayOfJob"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "Login"),
      "http://api.flexiscale.com",
      "login",
      [ ["in", "username", ["::SOAP::SOAPString"]],
        ["in", "password", ["::SOAP::SOAPString"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "Logout"),
      "https://api.flexiscale.com",
      "logout",
      [],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListRunningJobs"),
      "https://api.flexiscale.com",
      "listRunningJobs",
      [ ["retval", "ListRunningJobsReturn", ["FlexiScale::ArrayOfJob", "http://api.flexiscale.com", "ArrayOfJob"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListOperatingSystemImages"),
      "https://api.flexiscale.com",
      "listOperatingSystemImages",
      [ ["retval", "ListOperatingSystemImagesReturn", ["FlexiScale::ArrayOfOperatingSystemImage", "http://api.flexiscale.com", "ArrayOfOperatingSystemImage"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListDisks"),
      "https://api.flexiscale.com",
      "listDisks",
      [ ["in", "list", ["FlexiScale::ArrayOf_xsd_int", "http://api.flexiscale.com", "ArrayOf_xsd_int"]],
        ["retval", "ListDisksReturn", ["FlexiScale::ArrayOfDisk", "http://api.flexiscale.com", "ArrayOfDisk"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListDebitItems"),
      "https://api.flexiscale.com",
      "listDebitItems",
      [ ["in", "item_type", ["::SOAP::SOAPString"]],
        ["in", "type_id", ["::SOAP::SOAPInt"]],
        ["in", "start_date", ["::SOAP::SOAPInt"]],
        ["in", "end_date", ["::SOAP::SOAPInt"]],
        ["retval", "ListDebitItemsReturn", ["FlexiScale::ArrayOfDebitItem", "http://api.flexiscale.com", "ArrayOfDebitItem"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListCredits"),
      "https://api.flexiscale.com",
      "listCredits",
      [ ["in", "start_date", ["::SOAP::SOAPInt"]],
        ["in", "end_date", ["::SOAP::SOAPInt"]],
        ["retval", "ListCreditsReturn", ["FlexiScale::ArrayOfCredit", "http://api.flexiscale.com", "ArrayOfCredit"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListDebits"),
      "https://api.flexiscale.com",
      "listDebits",
      [ ["in", "start_date", ["::SOAP::SOAPInt"]],
        ["in", "end_date", ["::SOAP::SOAPInt"]],
        ["retval", "ListDebitsReturn", ["FlexiScale::ArrayOfDebit", "http://api.flexiscale.com", "ArrayOfDebit"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListNetworkInterfaces"),
      "https://api.flexiscale.com",
      "listNetworkInterfaces",
      [ ["in", "list", ["FlexiScale::ArrayOf_xsd_int", "http://api.flexiscale.com", "ArrayOf_xsd_int"]],
        ["retval", "ListNetworkInterfacesReturn", ["FlexiScale::ArrayOfNetworkInterface", "http://api.flexiscale.com", "ArrayOfNetworkInterface"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListVlans"),
      "https://api.flexiscale.com",
      "listVlans",
      [ ["in", "list", ["FlexiScale::ArrayOf_xsd_int", "http://api.flexiscale.com", "ArrayOf_xsd_int"]],
        ["retval", "ListVlansReturn", ["FlexiScale::ArrayOfVlan", "http://api.flexiscale.com", "ArrayOfVlan"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ListPackages"),
      "https://api.flexiscale.com",
      "listPackages",
      [ ["in", "list", ["FlexiScale::ArrayOf_xsd_int", "http://api.flexiscale.com", "ArrayOf_xsd_int"]],
        ["retval", "ListPackagesReturn", ["FlexiScale::ArrayOfPackage", "http://api.flexiscale.com", "ArrayOfPackage"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "StartServer"),
      "https://api.flexiscale.com",
      "startServer",
      [ ["in", "server_name", ["::SOAP::SOAPString"]],
        ["in", "notes", ["::SOAP::SOAPString"]],
        ["retval", "StartServerReturn", ["::SOAP::SOAPInt"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "StopServer"),
      "https://api.flexiscale.com",
      "stopServer",
      [ ["in", "server_name", ["::SOAP::SOAPString"]],
        ["in", "stop_method", ["::SOAP::SOAPInt"]],
        ["in", "notes", ["::SOAP::SOAPString"]],
        ["retval", "StopServerReturn", ["::SOAP::SOAPInt"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "RebootServer"),
      "https://api.flexiscale.com",
      "rebootServer",
      [ ["in", "server_name", ["::SOAP::SOAPString"]],
        ["in", "notes", ["::SOAP::SOAPString"]],
        ["retval", "RebootServerReturn", ["::SOAP::SOAPInt"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "StopStartServer"),
      "https://api.flexiscale.com",
      "stopStartServer",
      [ ["in", "server_name", ["::SOAP::SOAPString"]],
        ["in", "notes", ["::SOAP::SOAPString"]],
        ["retval", "StopStartServerReturn", ["::SOAP::SOAPInt"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "WaitForJobs"),
      "https://api.flexiscale.com",
      "waitForJobs",
      [ ["in", "list", ["FlexiScale::ArrayOf_xsd_int", "http://api.flexiscale.com", "ArrayOf_xsd_int"]],
        ["retval", "WaitForJobsReturn", ["::SOAP::SOAPBoolean"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "DestroyServer"),
      "https://api.flexiscale.com",
      "destroyServer",
      [ ["in", "server_name", ["::SOAP::SOAPString"]],
        ["retval", "DestroyServerReturn", ["::SOAP::SOAPInt"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "CreateServer"),
      "https://api.flexiscale.com",
      "createServer",
      [ ["in", "specification", ["FlexiScale::Server", "http://api.flexiscale.com", "Server"]],
        ["in", "vlan", ["FlexiScale::Vlan", "http://api.flexiscale.com", "Vlan"]],
        ["retval", "CreateServerReturn", ["::SOAP::SOAPInt"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ],
    [ XSD::QName.new(NsApiFlexiscaleCom, "ModifyServer"),
      "https://api.flexiscale.com",
      "modifyServer",
      [ ["in", "specification", ["FlexiScale::Server", "http://api.flexiscale.com", "Server"]],
        ["retval", "ModifyServerReturn", ["FlexiScale::Server", "http://api.flexiscale.com", "Server"]] ],
      { :request_style =>  :rpc, :request_use =>  :encoded,
        :response_style => :rpc, :response_use => :encoded,
        :faults => {} }
    ]
  ]

  def initialize(endpoint_url = nil)
    endpoint_url ||= DefaultEndpointUrl
    super(endpoint_url, nil)
    self.mapping_registry = FlexiscaleAPIMappingRegistry::EncodedRegistry
    self.literal_mapping_registry = FlexiscaleAPIMappingRegistry::LiteralRegistry
    init_methods
  end

private

  def init_methods
    Methods.each do |definitions|
      opt = definitions.last
      if opt[:request_style] == :document
        add_document_operation(*definitions)
      else
        add_rpc_operation(*definitions)
        qname = definitions[0]
        name = definitions[2]
        if qname.name != name and qname.name.capitalize == name.capitalize
          ::SOAP::Mapping.define_singleton_method(self, qname.name) do |*arg|
            __send__(name, *arg)
          end
        end
      end
    end
  end
end


end
