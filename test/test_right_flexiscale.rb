require File.dirname(__FILE__) + '/test_helper.rb'

class TestRightFlexiscale < Test::Unit::TestCase

  def setup
    @flexiscale = RightFlexiscale::Api.new
    @test_server_name = "right_flexiscale_awesome_test_server_1234567890"
  end
  
#=begin  

  def test_01_list_credits
    result = @flexiscale.list_credits
    assert result.is_a?(Array)
  end

#  def test_02_list_debit_items
#    result = @flexiscale.list_debit_items(a,b)
#    assert result.is_a?(Array)
#  end

  def test_03_list_debits
    result = @flexiscale.list_debits
    assert result.is_a?(Array)
  end
  
  def test_04_list_disks
    result = @flexiscale.list_disks
    assert result.is_a?(Array)
  end
  
  def test_05_list_firewall_protocols
    result = @flexiscale.list_firewall_protocols
    assert result.is_a?(Array)
  end
  
#  def test_06_list_firewall_rules
#    result = @flexiscale.list_firewall_rules(a)
#    assert result.is_a?(Array)
#  end
  
#  def test_07_list_firewall_template_rules
#    result = @flexiscale.list_firewall_template_rules(a)
#    assert result.is_a?(Array)
#  end
  
  def test_08_list_firewall_templates
    result = @flexiscale.list_firewall_templates
    assert result.is_a?(Array)
  end
  
  def test_09_list_firewalls
    result = @flexiscale.list_firewalls
    assert result.is_a?(Array)
  end
  
  def test_10_list_icmp_protocols
    result = @flexiscale.list_icmp_protocols
    assert result.is_a?(Array)
  end
  
  def test_11_list_ip_blocks
    result = @flexiscale.list_ip_blocks
    assert result.is_a?(Array)
  end
  
  def test_12_list_jobs
    #filter_jobs
    #list_running_jobs
  end
  
  def test_13_list_network_interfaces
    result = @flexiscale.list_network_interfaces
    assert result.is_a?(Array)
  end
  
  def test_14_list_operating_system_images
    result = @flexiscale.list_operating_system_images
    assert result.is_a?(Array)
  end
  
  def test_15_list_packages
    result = @flexiscale.list_packages
    assert result.is_a?(Array)
  end
  
  def test_16_list_vlans
    result = @flexiscale.list_vlans
    assert result.is_a?(Array)
  end
  
#=end
  
  #---------------------------
  # Servers
  #---------------------------

  def test_30_remove_test_server
    @flexiscale.destroy_server(@test_server_name) rescue nil
  end
  
  def test_31_list_servers
    result = @flexiscale.list_servers
    assert result.is_a?(Array)
  end
  
  def test_32_create_server
    image     = @flexiscale.list_operating_system_images.first
    package   = @flexiscale.list_packages.first
    vlan      = @flexiscale.list_vlans.first
    server_id = @flexiscale.create_server(@test_server_name, package[:fxs_id], 2, 2048, 20, image[:fxs_id], vlan[:fxs_id])
    assert server_id.is_a?(Fixnum)
  end
  
  def test_33_modify_server
    server = nil
    assert_nothing_raised do
      server = @flexiscale.list_servers(@test_server_name).first
    end
    assert_equal(2,    server[:processors])
    assert_equal(2048, server[:memory])
    # update the server and make sure the modifications were applied
    modified_server = @flexiscale.modify_server(server[:fxs_id], 1, 1024)
    assert_equal(1,    modified_server[:processors])
    assert_equal(1024, modified_server[:memory])
  end

  # TODO:reboot_server   start_server   stop_server   stop_start_server
  
  def test_39_destroy_server
    assert_nothing_raised do
      assert @flexiscale.destroy_server(@test_server_name)
    end
  end
  
end
