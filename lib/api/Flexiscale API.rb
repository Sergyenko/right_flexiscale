require 'xsd/qname'

module FlexiScale


# {http://api.flexiscale.com}OperatingSystemImage
#   operating_system_image_id - SOAP::SOAPInt
#   operating_system_image_name - SOAP::SOAPString
class OperatingSystemImage # :nodoc:
  attr_accessor :operating_system_image_id
  attr_accessor :operating_system_image_name

  def initialize(operating_system_image_id = nil, operating_system_image_name = nil)
    @operating_system_image_id = operating_system_image_id
    @operating_system_image_name = operating_system_image_name
  end
end

# {http://api.flexiscale.com}Disk
#   disk_id - SOAP::SOAPInt
#   package_id - SOAP::SOAPInt
#   capacity - SOAP::SOAPInt
#   usage - SOAP::SOAPFloat
#   server_id - SOAP::SOAPInt
#   locked - SOAP::SOAPInt
#   disk_name - SOAP::SOAPString
class Disk # :nodoc:
  attr_accessor :disk_id
  attr_accessor :package_id
  attr_accessor :capacity
  attr_accessor :usage
  attr_accessor :server_id
  attr_accessor :locked
  attr_accessor :disk_name

  def initialize(disk_id = nil, package_id = nil, capacity = nil, usage = nil, server_id = nil, locked = nil, disk_name = nil)
    @disk_id = disk_id
    @package_id = package_id
    @capacity = capacity
    @usage = usage
    @server_id = server_id
    @locked = locked
    @disk_name = disk_name
  end
end

# {http://api.flexiscale.com}NetworkInterface
#   network_interface_id - SOAP::SOAPInt
#   server_id - SOAP::SOAPInt
#   vlan_id - SOAP::SOAPInt
#   mac_address - SOAP::SOAPString
class NetworkInterface # :nodoc:
  attr_accessor :network_interface_id
  attr_accessor :server_id
  attr_accessor :vlan_id
  attr_accessor :mac_address

  def initialize(network_interface_id = nil, server_id = nil, vlan_id = nil, mac_address = nil)
    @network_interface_id = network_interface_id
    @server_id = server_id
    @vlan_id = vlan_id
    @mac_address = mac_address
  end
end

# {http://api.flexiscale.com}IpBlock
#   ip_block_id - SOAP::SOAPInt
#   start_ip - SOAP::SOAPString
#   end_ip - SOAP::SOAPString
#   block_type - SOAP::SOAPInt
#   customer_vlan_id - SOAP::SOAPInt
class IpBlock # :nodoc:
  attr_accessor :ip_block_id
  attr_accessor :start_ip
  attr_accessor :end_ip
  attr_accessor :block_type
  attr_accessor :customer_vlan_id

  def initialize(ip_block_id = nil, start_ip = nil, end_ip = nil, block_type = nil, customer_vlan_id = nil)
    @ip_block_id = ip_block_id
    @start_ip = start_ip
    @end_ip = end_ip
    @block_type = block_type
    @customer_vlan_id = customer_vlan_id
  end
end

# {http://api.flexiscale.com}Firewall
#   firewall_id - SOAP::SOAPInt
#   ip_address - SOAP::SOAPString
#   default_policy - SOAP::SOAPString
class Firewall # :nodoc:
  attr_accessor :firewall_id
  attr_accessor :ip_address
  attr_accessor :default_policy

  def initialize(firewall_id = nil, ip_address = nil, default_policy = nil)
    @firewall_id = firewall_id
    @ip_address = ip_address
    @default_policy = default_policy
  end
end

# {http://api.flexiscale.com}FirewallTemplate
#   firewall_template_id - SOAP::SOAPInt
#   template_name - SOAP::SOAPString
#   default_policy - SOAP::SOAPString
class FirewallTemplate # :nodoc:
  attr_accessor :firewall_template_id
  attr_accessor :template_name
  attr_accessor :default_policy

  def initialize(firewall_template_id = nil, template_name = nil, default_policy = nil)
    @firewall_template_id = firewall_template_id
    @template_name = template_name
    @default_policy = default_policy
  end
end

# {http://api.flexiscale.com}FirewallRule
#   firewall_rule_id - SOAP::SOAPInt
#   firewall_id - SOAP::SOAPInt
#   sequence_no - SOAP::SOAPInt
#   rule_name - SOAP::SOAPString
#   direction - SOAP::SOAPString
#   firewall_protocol_id - SOAP::SOAPInt
#   source_port - SOAP::SOAPInt
#   destination_port - SOAP::SOAPInt
#   icmp_parameter_id - SOAP::SOAPInt
#   ip_address - SOAP::SOAPString
#   ip_address_mask - SOAP::SOAPInt
#   action - SOAP::SOAPString
#   jump_to - SOAP::SOAPInt
class FirewallRule # :nodoc:
  attr_accessor :firewall_rule_id
  attr_accessor :firewall_id
  attr_accessor :sequence_no
  attr_accessor :rule_name
  attr_accessor :direction
  attr_accessor :firewall_protocol_id
  attr_accessor :source_port
  attr_accessor :destination_port
  attr_accessor :icmp_parameter_id
  attr_accessor :ip_address
  attr_accessor :ip_address_mask
  attr_accessor :action
  attr_accessor :jump_to

  def initialize(firewall_rule_id = nil, firewall_id = nil, sequence_no = nil, rule_name = nil, direction = nil, firewall_protocol_id = nil, source_port = nil, destination_port = nil, icmp_parameter_id = nil, ip_address = nil, ip_address_mask = nil, action = nil, jump_to = nil)
    @firewall_rule_id = firewall_rule_id
    @firewall_id = firewall_id
    @sequence_no = sequence_no
    @rule_name = rule_name
    @direction = direction
    @firewall_protocol_id = firewall_protocol_id
    @source_port = source_port
    @destination_port = destination_port
    @icmp_parameter_id = icmp_parameter_id
    @ip_address = ip_address
    @ip_address_mask = ip_address_mask
    @action = action
    @jump_to = jump_to
  end
end

# {http://api.flexiscale.com}FirewallTemplateRule
#   firewall_template_rule_id - SOAP::SOAPInt
#   firewall_template_id - SOAP::SOAPInt
#   sequence_no - SOAP::SOAPInt
#   rule_name - SOAP::SOAPString
#   direction - SOAP::SOAPString
#   firewall_protocol_id - SOAP::SOAPInt
#   source_port - SOAP::SOAPInt
#   destination_port - SOAP::SOAPInt
#   icmp_parameter_id - SOAP::SOAPInt
#   ip_address - SOAP::SOAPString
#   ip_address_mask - SOAP::SOAPInt
#   action - SOAP::SOAPString
#   jump_to - SOAP::SOAPInt
class FirewallTemplateRule # :nodoc:
  attr_accessor :firewall_template_rule_id
  attr_accessor :firewall_template_id
  attr_accessor :sequence_no
  attr_accessor :rule_name
  attr_accessor :direction
  attr_accessor :firewall_protocol_id
  attr_accessor :source_port
  attr_accessor :destination_port
  attr_accessor :icmp_parameter_id
  attr_accessor :ip_address
  attr_accessor :ip_address_mask
  attr_accessor :action
  attr_accessor :jump_to

  def initialize(firewall_template_rule_id = nil, firewall_template_id = nil, sequence_no = nil, rule_name = nil, direction = nil, firewall_protocol_id = nil, source_port = nil, destination_port = nil, icmp_parameter_id = nil, ip_address = nil, ip_address_mask = nil, action = nil, jump_to = nil)
    @firewall_template_rule_id = firewall_template_rule_id
    @firewall_template_id = firewall_template_id
    @sequence_no = sequence_no
    @rule_name = rule_name
    @direction = direction
    @firewall_protocol_id = firewall_protocol_id
    @source_port = source_port
    @destination_port = destination_port
    @icmp_parameter_id = icmp_parameter_id
    @ip_address = ip_address
    @ip_address_mask = ip_address_mask
    @action = action
    @jump_to = jump_to
  end
end

# {http://api.flexiscale.com}IcmpProtocol
#   icmp_protocol_id - SOAP::SOAPInt
#   description - SOAP::SOAPString
class IcmpProtocol # :nodoc:
  attr_accessor :icmp_protocol_id
  attr_accessor :description

  def initialize(icmp_protocol_id = nil, description = nil)
    @icmp_protocol_id = icmp_protocol_id
    @description = description
  end
end

# {http://api.flexiscale.com}FirewallProtocol
#   firewall_protocol_id - SOAP::SOAPInt
#   name - SOAP::SOAPString
class FirewallProtocol # :nodoc:
  attr_accessor :firewall_protocol_id
  attr_accessor :name

  def initialize(firewall_protocol_id = nil, name = nil)
    @firewall_protocol_id = firewall_protocol_id
    @name = name
  end
end

# {http://api.flexiscale.com}Vlan
#   vlan_id - SOAP::SOAPInt
#   vlan_name - SOAP::SOAPString
class Vlan # :nodoc:
  attr_accessor :vlan_id
  attr_accessor :vlan_name

  def initialize(vlan_id = nil, vlan_name = nil)
    @vlan_id = vlan_id
    @vlan_name = vlan_name
  end
end

# {http://api.flexiscale.com}Server
#   server_id - SOAP::SOAPInt
#   server_name - SOAP::SOAPString
#   status - SOAP::SOAPString
#   package_id - SOAP::SOAPInt
#   processors - SOAP::SOAPInt
#   memory - SOAP::SOAPInt
#   operating_system_image - FlexiScale::OperatingSystemImage
#   disk_capacity - SOAP::SOAPLong
#   disks - FlexiScale::ArrayOf_xsd_int
#   network_interfaces - FlexiScale::ArrayOf_xsd_int
#   initial_password - SOAP::SOAPString
#   uptime - SOAP::SOAPLong
#   ip_addresses - FlexiScale::ArrayOf_xsd_string
#   modified - SOAP::SOAPBoolean
class Server # :nodoc:
  attr_accessor :server_id
  attr_accessor :server_name
  attr_accessor :status
  attr_accessor :package_id
  attr_accessor :processors
  attr_accessor :memory
  attr_accessor :operating_system_image
  attr_accessor :disk_capacity
  attr_accessor :disks
  attr_accessor :network_interfaces
  attr_accessor :initial_password
  attr_accessor :uptime
  attr_accessor :ip_addresses
  attr_accessor :modified

  def initialize(server_id = nil, server_name = nil, status = nil, package_id = nil, processors = nil, memory = nil, operating_system_image = nil, disk_capacity = nil, disks = nil, network_interfaces = nil, initial_password = nil, uptime = nil, ip_addresses = nil, modified = nil)
    @server_id = server_id
    @server_name = server_name
    @status = status
    @package_id = package_id
    @processors = processors
    @memory = memory
    @operating_system_image = operating_system_image
    @disk_capacity = disk_capacity
    @disks = disks
    @network_interfaces = network_interfaces
    @initial_password = initial_password
    @uptime = uptime
    @ip_addresses = ip_addresses
    @modified = modified
  end
  
  def on_simple_outbound
    { 'kd' => 1234567 }
  end
  
end

# {http://api.flexiscale.com}Job
#   job_id - SOAP::SOAPInt
#   type_id - SOAP::SOAPInt
#   status - SOAP::SOAPInt
#   started - SOAP::SOAPDateTime
#   finished - SOAP::SOAPDateTime
#   description - SOAP::SOAPString
#   parent_job - SOAP::SOAPInt
#   notes - SOAP::SOAPString
class Job # :nodoc:
  attr_accessor :job_id
  attr_accessor :type_id
  attr_accessor :status
  attr_accessor :started
  attr_accessor :finished
  attr_accessor :description
  attr_accessor :parent_job
  attr_accessor :notes

  def initialize(job_id = nil, type_id = nil, status = nil, started = nil, finished = nil, description = nil, parent_job = nil, notes = nil)
    @job_id = job_id
    @type_id = type_id
    @status = status
    @started = started
    @finished = finished
    @description = description
    @parent_job = parent_job
    @notes = notes
  end
end

# {http://api.flexiscale.com}Package
#   package_id - SOAP::SOAPInt
#   package_name - SOAP::SOAPString
class Package # :nodoc:
  attr_accessor :package_id
  attr_accessor :package_name

  def initialize(package_id = nil, package_name = nil)
    @package_id = package_id
    @package_name = package_name
  end
end

# {http://api.flexiscale.com}DebitItem
#   debit_item_id - SOAP::SOAPInt
#   item_type - SOAP::SOAPString
#   type_id - SOAP::SOAPInt
#   item_value - SOAP::SOAPFloat
#   item_cost - SOAP::SOAPFloat
#   debit_id - SOAP::SOAPInt
#   description - SOAP::SOAPString
#   timestamp - SOAP::SOAPString
class DebitItem # :nodoc:
  attr_accessor :debit_item_id
  attr_accessor :item_type
  attr_accessor :type_id
  attr_accessor :item_value
  attr_accessor :item_cost
  attr_accessor :debit_id
  attr_accessor :description
  attr_accessor :timestamp

  def initialize(debit_item_id = nil, item_type = nil, type_id = nil, item_value = nil, item_cost = nil, debit_id = nil, description = nil, timestamp = nil)
    @debit_item_id = debit_item_id
    @item_type = item_type
    @type_id = type_id
    @item_value = item_value
    @item_cost = item_cost
    @debit_id = debit_id
    @description = description
    @timestamp = timestamp
  end
end

# {http://api.flexiscale.com}Debit
#   debit_id - SOAP::SOAPInt
#   creation_time - SOAP::SOAPString
#   item_count - SOAP::SOAPInt
#   item_cost - SOAP::SOAPFloat
class Debit # :nodoc:
  attr_accessor :debit_id
  attr_accessor :creation_time
  attr_accessor :item_count
  attr_accessor :item_cost

  def initialize(debit_id = nil, creation_time = nil, item_count = nil, item_cost = nil)
    @debit_id = debit_id
    @creation_time = creation_time
    @item_count = item_count
    @item_cost = item_cost
  end
end

# {http://api.flexiscale.com}Credit
#   credit_id - SOAP::SOAPInt
#   credit_date - SOAP::SOAPString
#   credit_amount - SOAP::SOAPFloat
#   unused_credit - SOAP::SOAPFloat
class Credit # :nodoc:
  attr_accessor :credit_id
  attr_accessor :credit_date
  attr_accessor :credit_amount
  attr_accessor :unused_credit

  def initialize(credit_id = nil, credit_date = nil, credit_amount = nil, unused_credit = nil)
    @credit_id = credit_id
    @credit_date = credit_date
    @credit_amount = credit_amount
    @unused_credit = unused_credit
  end
end

# {http://api.flexiscale.com}CreditDebit
#   credit_debit_id - SOAP::SOAPInt
#   credit_id - SOAP::SOAPInt
#   debit_id - SOAP::SOAPInt
#   amount - SOAP::SOAPFloat
class CreditDebit # :nodoc:
  attr_accessor :credit_debit_id
  attr_accessor :credit_id
  attr_accessor :debit_id
  attr_accessor :amount

  def initialize(credit_debit_id = nil, credit_id = nil, debit_id = nil, amount = nil)
    @credit_debit_id = credit_debit_id
    @credit_id = credit_id
    @debit_id = debit_id
    @amount = amount
  end
end

# {http://api.flexiscale.com}ArrayOf_xsd_int
class ArrayOf_xsd_int < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOf_xsd_string
class ArrayOf_xsd_string < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfServer
class ArrayOfServer < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfOperatingSystemImage
class ArrayOfOperatingSystemImage < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfFirewall
class ArrayOfFirewall < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfFirewallTemplate
class ArrayOfFirewallTemplate < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfFirewallRule
class ArrayOfFirewallRule < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfFirewallTemplateRule
class ArrayOfFirewallTemplateRule < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfIcmpProtocol
class ArrayOfIcmpProtocol < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfFirewallProtocol
class ArrayOfFirewallProtocol < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfIpBlock
class ArrayOfIpBlock < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfVlan
class ArrayOfVlan < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfNetworkInterface
class ArrayOfNetworkInterface < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfDisk
class ArrayOfDisk < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfJob
class ArrayOfJob < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfPackage
class ArrayOfPackage < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfDebitItem
class ArrayOfDebitItem < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfDebit
class ArrayOfDebit < ::Array # :nodoc:
end

# {http://api.flexiscale.com}ArrayOfCredit
class ArrayOfCredit < ::Array # :nodoc:
end

end
