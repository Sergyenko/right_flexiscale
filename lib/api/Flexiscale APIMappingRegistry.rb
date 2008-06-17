require 'Flexiscale API.rb'
require 'soap/mapping'

module FlexiScale

module FlexiscaleAPIMappingRegistry
  EncodedRegistry = ::SOAP::Mapping::EncodedRegistry.new
  LiteralRegistry = ::SOAP::Mapping::LiteralRegistry.new
  NsApiFlexiscaleCom = "http://api.flexiscale.com"

  EncodedRegistry.set(
    FlexiScale::ArrayOf_xsd_int,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new("http://www.w3.org/2001/XMLSchema", "int") }
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOf_xsd_string,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new("http://www.w3.org/2001/XMLSchema", "string") }
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfServer,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new("http://api.flexiscale.com", "Server") }
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfOperatingSystemImage,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new("http://api.flexiscale.com", "OperatingSystemImage") }
  )

  EncodedRegistry.register(
    :class => FlexiScale::OperatingSystemImage,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "OperatingSystemImage"),
    :schema_element => [
      ["operating_system_image_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "operating_system_image_id")]],
      ["operating_system_image_name", ["SOAP::SOAPString", XSD::QName.new(nil, "operating_system_image_name")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => FlexiScale::Disk,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Disk"),
    :schema_element => [
      ["disk_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "disk_id")]],
      ["package_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "package_id")]],
      ["capacity", ["SOAP::SOAPInt", XSD::QName.new(nil, "capacity")]],
      ["usage", ["SOAP::SOAPFloat", XSD::QName.new(nil, "usage")]],
      ["server_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "server_id")]],
      ["locked", ["SOAP::SOAPInt", XSD::QName.new(nil, "locked")]],
      ["disk_name", ["SOAP::SOAPString", XSD::QName.new(nil, "disk_name")]]
    ]
  )

  EncodedRegistry.register(
    :class => FlexiScale::NetworkInterface,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "NetworkInterface"),
    :schema_element => [
      ["network_interface_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "network_interface_id")]],
      ["server_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "server_id")]],
      ["vlan_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "vlan_id")]],
      ["mac_address", ["SOAP::SOAPString", XSD::QName.new(nil, "mac_address")]]
    ]
  )

  EncodedRegistry.register(
    :class => FlexiScale::IpBlock,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "IpBlock"),
    :schema_element => [
      ["ip_block_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "ip_block_id")]],
      ["start_ip", ["SOAP::SOAPString", XSD::QName.new(nil, "start_ip")]],
      ["end_ip", ["SOAP::SOAPString", XSD::QName.new(nil, "end_ip")]],
      ["block_type", ["SOAP::SOAPInt", XSD::QName.new(nil, "block_type")]],
      ["customer_vlan_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "customer_vlan_id")]]
    ]
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfFirewall,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "Firewall") }
  )

  EncodedRegistry.register(
    :class => FlexiScale::Firewall,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Firewall"),
    :schema_element => [
      ["firewall_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_id")]],
      ["ip_address", ["SOAP::SOAPString", XSD::QName.new(nil, "ip_address")]],
      ["default_policy", ["SOAP::SOAPString", XSD::QName.new(nil, "default_policy")]]
    ]
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfFirewallTemplate,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "FirewallTemplate") }
  )

  EncodedRegistry.register(
    :class => FlexiScale::FirewallTemplate,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "FirewallTemplate"),
    :schema_element => [
      ["firewall_template_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_template_id")]],
      ["template_name", ["SOAP::SOAPString", XSD::QName.new(nil, "template_name")]],
      ["default_policy", ["SOAP::SOAPString", XSD::QName.new(nil, "default_policy")]]
    ]
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfFirewallRule,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "FirewallRule") }
  )

  EncodedRegistry.register(
    :class => FlexiScale::FirewallRule,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "FirewallRule"),
    :schema_element => [
      ["firewall_rule_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_rule_id")]],
      ["firewall_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_id")]],
      ["sequence_no", ["SOAP::SOAPInt", XSD::QName.new(nil, "sequence_no")]],
      ["rule_name", ["SOAP::SOAPString", XSD::QName.new(nil, "rule_name")]],
      ["direction", ["SOAP::SOAPString", XSD::QName.new(nil, "direction")]],
      ["firewall_protocol_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_protocol_id")]],
      ["source_port", ["SOAP::SOAPInt", XSD::QName.new(nil, "source_port")]],
      ["destination_port", ["SOAP::SOAPInt", XSD::QName.new(nil, "destination_port")]],
      ["icmp_parameter_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "icmp_parameter_id")]],
      ["ip_address", ["SOAP::SOAPString", XSD::QName.new(nil, "ip_address")]],
      ["ip_address_mask", ["SOAP::SOAPInt", XSD::QName.new(nil, "ip_address_mask")]],
      ["action", ["SOAP::SOAPString", XSD::QName.new(nil, "action")]],
      ["jump_to", ["SOAP::SOAPInt", XSD::QName.new(nil, "jump_to")]]
    ]
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfFirewallTemplateRule,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "FirewallTemplateRule") }
  )

  EncodedRegistry.register(
    :class => FlexiScale::FirewallTemplateRule,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "FirewallTemplateRule"),
    :schema_element => [
      ["firewall_template_rule_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_template_rule_id")]],
      ["firewall_template_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_template_id")]],
      ["sequence_no", ["SOAP::SOAPInt", XSD::QName.new(nil, "sequence_no")]],
      ["rule_name", ["SOAP::SOAPString", XSD::QName.new(nil, "rule_name")]],
      ["direction", ["SOAP::SOAPString", XSD::QName.new(nil, "direction")]],
      ["firewall_protocol_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_protocol_id")]],
      ["source_port", ["SOAP::SOAPInt", XSD::QName.new(nil, "source_port")]],
      ["destination_port", ["SOAP::SOAPInt", XSD::QName.new(nil, "destination_port")]],
      ["icmp_parameter_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "icmp_parameter_id")]],
      ["ip_address", ["SOAP::SOAPString", XSD::QName.new(nil, "ip_address")]],
      ["ip_address_mask", ["SOAP::SOAPInt", XSD::QName.new(nil, "ip_address_mask")]],
      ["action", ["SOAP::SOAPString", XSD::QName.new(nil, "action")]],
      ["jump_to", ["SOAP::SOAPInt", XSD::QName.new(nil, "jump_to")]]
    ]
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfIcmpProtocol,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "IcmpProtocol") }
  )

  EncodedRegistry.register(
    :class => FlexiScale::IcmpProtocol,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "IcmpProtocol"),
    :schema_element => [
      ["icmp_protocol_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "icmp_protocol_id")]],
      ["description", ["SOAP::SOAPString", XSD::QName.new(nil, "description")]]
    ]
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfFirewallProtocol,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "FirewallProtocol") }
  )

  EncodedRegistry.register(
    :class => FlexiScale::FirewallProtocol,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "FirewallProtocol"),
    :schema_element => [
      ["firewall_protocol_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_protocol_id")]],
      ["name", ["SOAP::SOAPString", XSD::QName.new(nil, "name")]]
    ]
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfIpBlock,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "IpBlock") }
  )

  EncodedRegistry.register(
    :class => FlexiScale::Vlan,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Vlan"),
    :schema_element => [
      ["vlan_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "vlan_id")]],
      ["vlan_name", ["SOAP::SOAPString", XSD::QName.new(nil, "vlan_name")], [0, 1]]
    ]
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfVlan,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "Vlan") }
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfNetworkInterface,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "NetworkInterface") }
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfDisk,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "Disk") }
  )

  EncodedRegistry.register(
    :class => FlexiScale::Server,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Server"),
    :schema_element => [
      ["server_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "server_id")], [0, 1]],
      ["server_name", ["SOAP::SOAPString", XSD::QName.new(nil, "server_name")], [0, 1]],
      ["status", ["SOAP::SOAPString", XSD::QName.new(nil, "status")], [0, 1]],
      ["package_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "package_id")], [0, 1]],
      ["processors", ["SOAP::SOAPInt", XSD::QName.new(nil, "processors")], [0, 1]],
      ["memory", ["SOAP::SOAPInt", XSD::QName.new(nil, "memory")], [0, 1]],
      ["operating_system_image", ["FlexiScale::OperatingSystemImage", XSD::QName.new(nil, "operating_system_image")], [0, 1]],
      ["disk_capacity", ["SOAP::SOAPLong", XSD::QName.new(nil, "disk_capacity")], [0, 1]],
      ["disks", ["FlexiScale::ArrayOf_xsd_int", XSD::QName.new(nil, "disks")], [0, 1]],
      ["network_interfaces", ["FlexiScale::ArrayOf_xsd_int", XSD::QName.new(nil, "network_interfaces")], [0, 1]],
      ["initial_password", ["SOAP::SOAPString", XSD::QName.new(nil, "initial_password")], [0, 1]],
      ["uptime", ["SOAP::SOAPLong", XSD::QName.new(nil, "uptime")], [0, 1]],
      ["ip_addresses", ["FlexiScale::ArrayOf_xsd_string", XSD::QName.new(nil, "ip_addresses")], [0, 1]],
      ["modified", ["SOAP::SOAPBoolean", XSD::QName.new(nil, "modified")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => FlexiScale::Job,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Job"),
    :schema_element => [
      ["job_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "job_id")]],
      ["type_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "type_id")]],
      ["status", ["SOAP::SOAPInt", XSD::QName.new(nil, "status")]],
      ["started", ["SOAP::SOAPDateTime", XSD::QName.new(nil, "started")]],
      ["finished", ["SOAP::SOAPDateTime", XSD::QName.new(nil, "finished")]],
      ["description", ["SOAP::SOAPString", XSD::QName.new(nil, "description")]],
      ["parent_job", ["SOAP::SOAPInt", XSD::QName.new(nil, "parent_job")]],
      ["notes", ["SOAP::SOAPString", XSD::QName.new(nil, "notes")]]
    ]
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfJob,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "Job") }
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfPackage,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "Package") }
  )

  EncodedRegistry.register(
    :class => FlexiScale::Package,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Package"),
    :schema_element => [
      ["package_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "package_id")]],
      ["package_name", ["SOAP::SOAPString", XSD::QName.new(nil, "package_name")]]
    ]
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfDebitItem,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "DebitItem") }
  )

  EncodedRegistry.register(
    :class => FlexiScale::DebitItem,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "DebitItem"),
    :schema_element => [
      ["debit_item_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "debit_item_id")]],
      ["item_type", ["SOAP::SOAPString", XSD::QName.new(nil, "item_type")]],
      ["type_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "type_id")]],
      ["item_value", ["SOAP::SOAPFloat", XSD::QName.new(nil, "item_value")]],
      ["item_cost", ["SOAP::SOAPFloat", XSD::QName.new(nil, "item_cost")]],
      ["debit_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "debit_id")]],
      ["description", ["SOAP::SOAPString", XSD::QName.new(nil, "description")]],
      ["timestamp", ["SOAP::SOAPString", XSD::QName.new(nil, "timestamp")]]
    ]
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfDebit,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "Debit") }
  )

  EncodedRegistry.register(
    :class => FlexiScale::Debit,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Debit"),
    :schema_element => [
      ["debit_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "debit_id")]],
      ["creation_time", ["SOAP::SOAPString", XSD::QName.new(nil, "creation_time")]],
      ["item_count", ["SOAP::SOAPInt", XSD::QName.new(nil, "item_count")]],
      ["item_cost", ["SOAP::SOAPFloat", XSD::QName.new(nil, "item_cost")]]
    ]
  )

  EncodedRegistry.set(
    FlexiScale::ArrayOfCredit,
    ::SOAP::SOAPArray,
    ::SOAP::Mapping::EncodedRegistry::TypedArrayFactory,
    { :type => XSD::QName.new(NsApiFlexiscaleCom, "Credit") }
  )

  EncodedRegistry.register(
    :class => FlexiScale::Credit,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Credit"),
    :schema_element => [
      ["credit_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "credit_id")]],
      ["credit_date", ["SOAP::SOAPString", XSD::QName.new(nil, "credit_date")]],
      ["credit_amount", ["SOAP::SOAPFloat", XSD::QName.new(nil, "credit_amount")]],
      ["unused_credit", ["SOAP::SOAPFloat", XSD::QName.new(nil, "unused_credit")]]
    ]
  )

  EncodedRegistry.register(
    :class => FlexiScale::CreditDebit,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "CreditDebit"),
    :schema_element => [
      ["credit_debit_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "credit_debit_id")]],
      ["credit_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "credit_id")]],
      ["debit_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "debit_id")]],
      ["amount", ["SOAP::SOAPFloat", XSD::QName.new(nil, "amount")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::OperatingSystemImage,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "OperatingSystemImage"),
    :schema_element => [
      ["operating_system_image_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "operating_system_image_id")]],
      ["operating_system_image_name", ["SOAP::SOAPString", XSD::QName.new(nil, "operating_system_image_name")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::Disk,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Disk"),
    :schema_element => [
      ["disk_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "disk_id")]],
      ["package_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "package_id")]],
      ["capacity", ["SOAP::SOAPInt", XSD::QName.new(nil, "capacity")]],
      ["usage", ["SOAP::SOAPFloat", XSD::QName.new(nil, "usage")]],
      ["server_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "server_id")]],
      ["locked", ["SOAP::SOAPInt", XSD::QName.new(nil, "locked")]],
      ["disk_name", ["SOAP::SOAPString", XSD::QName.new(nil, "disk_name")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::NetworkInterface,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "NetworkInterface"),
    :schema_element => [
      ["network_interface_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "network_interface_id")]],
      ["server_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "server_id")]],
      ["vlan_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "vlan_id")]],
      ["mac_address", ["SOAP::SOAPString", XSD::QName.new(nil, "mac_address")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::IpBlock,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "IpBlock"),
    :schema_element => [
      ["ip_block_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "ip_block_id")]],
      ["start_ip", ["SOAP::SOAPString", XSD::QName.new(nil, "start_ip")]],
      ["end_ip", ["SOAP::SOAPString", XSD::QName.new(nil, "end_ip")]],
      ["block_type", ["SOAP::SOAPInt", XSD::QName.new(nil, "block_type")]],
      ["customer_vlan_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "customer_vlan_id")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::Firewall,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Firewall"),
    :schema_element => [
      ["firewall_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_id")]],
      ["ip_address", ["SOAP::SOAPString", XSD::QName.new(nil, "ip_address")]],
      ["default_policy", ["SOAP::SOAPString", XSD::QName.new(nil, "default_policy")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::FirewallTemplate,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "FirewallTemplate"),
    :schema_element => [
      ["firewall_template_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_template_id")]],
      ["template_name", ["SOAP::SOAPString", XSD::QName.new(nil, "template_name")]],
      ["default_policy", ["SOAP::SOAPString", XSD::QName.new(nil, "default_policy")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::FirewallRule,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "FirewallRule"),
    :schema_element => [
      ["firewall_rule_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_rule_id")]],
      ["firewall_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_id")]],
      ["sequence_no", ["SOAP::SOAPInt", XSD::QName.new(nil, "sequence_no")]],
      ["rule_name", ["SOAP::SOAPString", XSD::QName.new(nil, "rule_name")]],
      ["direction", ["SOAP::SOAPString", XSD::QName.new(nil, "direction")]],
      ["firewall_protocol_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_protocol_id")]],
      ["source_port", ["SOAP::SOAPInt", XSD::QName.new(nil, "source_port")]],
      ["destination_port", ["SOAP::SOAPInt", XSD::QName.new(nil, "destination_port")]],
      ["icmp_parameter_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "icmp_parameter_id")]],
      ["ip_address", ["SOAP::SOAPString", XSD::QName.new(nil, "ip_address")]],
      ["ip_address_mask", ["SOAP::SOAPInt", XSD::QName.new(nil, "ip_address_mask")]],
      ["action", ["SOAP::SOAPString", XSD::QName.new(nil, "action")]],
      ["jump_to", ["SOAP::SOAPInt", XSD::QName.new(nil, "jump_to")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::FirewallTemplateRule,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "FirewallTemplateRule"),
    :schema_element => [
      ["firewall_template_rule_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_template_rule_id")]],
      ["firewall_template_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_template_id")]],
      ["sequence_no", ["SOAP::SOAPInt", XSD::QName.new(nil, "sequence_no")]],
      ["rule_name", ["SOAP::SOAPString", XSD::QName.new(nil, "rule_name")]],
      ["direction", ["SOAP::SOAPString", XSD::QName.new(nil, "direction")]],
      ["firewall_protocol_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_protocol_id")]],
      ["source_port", ["SOAP::SOAPInt", XSD::QName.new(nil, "source_port")]],
      ["destination_port", ["SOAP::SOAPInt", XSD::QName.new(nil, "destination_port")]],
      ["icmp_parameter_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "icmp_parameter_id")]],
      ["ip_address", ["SOAP::SOAPString", XSD::QName.new(nil, "ip_address")]],
      ["ip_address_mask", ["SOAP::SOAPInt", XSD::QName.new(nil, "ip_address_mask")]],
      ["action", ["SOAP::SOAPString", XSD::QName.new(nil, "action")]],
      ["jump_to", ["SOAP::SOAPInt", XSD::QName.new(nil, "jump_to")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::IcmpProtocol,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "IcmpProtocol"),
    :schema_element => [
      ["icmp_protocol_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "icmp_protocol_id")]],
      ["description", ["SOAP::SOAPString", XSD::QName.new(nil, "description")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::FirewallProtocol,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "FirewallProtocol"),
    :schema_element => [
      ["firewall_protocol_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "firewall_protocol_id")]],
      ["name", ["SOAP::SOAPString", XSD::QName.new(nil, "name")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::Vlan,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Vlan"),
    :schema_element => [
      ["vlan_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "vlan_id")]],
      ["vlan_name", ["SOAP::SOAPString", XSD::QName.new(nil, "vlan_name")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::Server,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Server"),
    :schema_element => [
      ["server_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "server_id")], [0, 1]],
      ["server_name", ["SOAP::SOAPString", XSD::QName.new(nil, "server_name")], [0, 1]],
      ["status", ["SOAP::SOAPString", XSD::QName.new(nil, "status")], [0, 1]],
      ["package_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "package_id")], [0, 1]],
      ["processors", ["SOAP::SOAPInt", XSD::QName.new(nil, "processors")], [0, 1]],
      ["memory", ["SOAP::SOAPInt", XSD::QName.new(nil, "memory")], [0, 1]],
      ["operating_system_image", ["FlexiScale::OperatingSystemImage", XSD::QName.new(nil, "operating_system_image")], [0, 1]],
      ["disk_capacity", ["SOAP::SOAPLong", XSD::QName.new(nil, "disk_capacity")], [0, 1]],
      ["disks", ["FlexiScale::ArrayOf_xsd_int", XSD::QName.new(nil, "disks")], [0, 1]],
      ["network_interfaces", ["FlexiScale::ArrayOf_xsd_int", XSD::QName.new(nil, "network_interfaces")], [0, 1]],
      ["initial_password", ["SOAP::SOAPString", XSD::QName.new(nil, "initial_password")], [0, 1]],
      ["uptime", ["SOAP::SOAPLong", XSD::QName.new(nil, "uptime")], [0, 1]],
      ["ip_addresses", ["FlexiScale::ArrayOf_xsd_string", XSD::QName.new(nil, "ip_addresses")], [0, 1]],
      ["modified", ["SOAP::SOAPBoolean", XSD::QName.new(nil, "modified")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::Job,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Job"),
    :schema_element => [
      ["job_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "job_id")]],
      ["type_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "type_id")]],
      ["status", ["SOAP::SOAPInt", XSD::QName.new(nil, "status")]],
      ["started", ["SOAP::SOAPDateTime", XSD::QName.new(nil, "started")]],
      ["finished", ["SOAP::SOAPDateTime", XSD::QName.new(nil, "finished")]],
      ["description", ["SOAP::SOAPString", XSD::QName.new(nil, "description")]],
      ["parent_job", ["SOAP::SOAPInt", XSD::QName.new(nil, "parent_job")]],
      ["notes", ["SOAP::SOAPString", XSD::QName.new(nil, "notes")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::Package,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Package"),
    :schema_element => [
      ["package_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "package_id")]],
      ["package_name", ["SOAP::SOAPString", XSD::QName.new(nil, "package_name")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::DebitItem,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "DebitItem"),
    :schema_element => [
      ["debit_item_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "debit_item_id")]],
      ["item_type", ["SOAP::SOAPString", XSD::QName.new(nil, "item_type")]],
      ["type_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "type_id")]],
      ["item_value", ["SOAP::SOAPFloat", XSD::QName.new(nil, "item_value")]],
      ["item_cost", ["SOAP::SOAPFloat", XSD::QName.new(nil, "item_cost")]],
      ["debit_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "debit_id")]],
      ["description", ["SOAP::SOAPString", XSD::QName.new(nil, "description")]],
      ["timestamp", ["SOAP::SOAPString", XSD::QName.new(nil, "timestamp")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::Debit,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Debit"),
    :schema_element => [
      ["debit_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "debit_id")]],
      ["creation_time", ["SOAP::SOAPString", XSD::QName.new(nil, "creation_time")]],
      ["item_count", ["SOAP::SOAPInt", XSD::QName.new(nil, "item_count")]],
      ["item_cost", ["SOAP::SOAPFloat", XSD::QName.new(nil, "item_cost")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::Credit,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "Credit"),
    :schema_element => [
      ["credit_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "credit_id")]],
      ["credit_date", ["SOAP::SOAPString", XSD::QName.new(nil, "credit_date")]],
      ["credit_amount", ["SOAP::SOAPFloat", XSD::QName.new(nil, "credit_amount")]],
      ["unused_credit", ["SOAP::SOAPFloat", XSD::QName.new(nil, "unused_credit")]]
    ]
  )

  LiteralRegistry.register(
    :class => FlexiScale::CreditDebit,
    :schema_type => XSD::QName.new(NsApiFlexiscaleCom, "CreditDebit"),
    :schema_element => [
      ["credit_debit_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "credit_debit_id")]],
      ["credit_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "credit_id")]],
      ["debit_id", ["SOAP::SOAPInt", XSD::QName.new(nil, "debit_id")]],
      ["amount", ["SOAP::SOAPFloat", XSD::QName.new(nil, "amount")]]
    ]
  )
end

end
