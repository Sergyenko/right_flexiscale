class TestFlexiscaleCredentials

  @@username = nil 
  @@password = nil 

  def self.username
    @@username
  end
  def self.username=(newval)
    @@username = newval
  end
  def self.password
    @@password
  end
  def self.password=(newval)
    @@password = newval
  end

# Make sure you have environment vars set:
# 
# export FLEXISCALE_USERNAME='your_flexiscale_username'
# export FLEXISCALE_PASSWORD='your_flexiscale_password'
#
# or you have a file: ~/.rightscale/test_flexiscale_credentials.rb with text:
# 
#  TestFlexiscaleCredentials.username = 'your_flexiscale_username'
#  TestFlexiscaleCredentials.password = 'your_flexiscale_password'
#
  def self.get_credentials
    Dir.chdir do
      begin
        Dir.chdir('./.rightscale') do 
          require 'test_flexiscale_credentials'
        end
      rescue Exception => e
        puts "Couldn't chdir to ~/.rightscale: #{e.message}"
      end
    end
  end
end
