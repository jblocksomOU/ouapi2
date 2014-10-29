module OUApi
class Runner
### RSPEC Runner Class; Assists in Running a Suite of Rspec tests ####

  def initialize(spec,settings = nil,format = "d", out_path = nil)
    spec_helper(settings)
    command = ["#{OUApi.spec_root}/#{spec}", "--format", "documentation","--format",format, "--out",out_path]
    run_spec(command)
  end

  def run_spec(command)
    RSpec::Core::Runner.run(command)
    RSpec.reset
  end

  #thanks: http://old.rspec.info/documentation/before_and_after.html
   def spec_helper(settings)
      spec_settings = settings || {}#if settings is nil, then use the defauly values in the config file

      RSpec.configure do |config|  
        config.before :all do
          if settings[:type] == "superadmin"
            @host = settings[:host]
            @skin = settings[:skin]
            puts "Enter username:"
            username = gets.chomp
            puts "Enter password:"
            password = STDIN.noecho(&:gets).chomp
            @user = OUApi::SuperAdmin.new(@host,@skin,username,password)
          else
            @login_params = {
            host: settings[:host] || OUApi.default[:host],
            skin: settings[:skin] || OUApi.default[:skin], 
            account: settings[:account] || OUApi.default[:account],
            site: settings[:site] || OUApi.default[:site],
            username: settings[:username] || OUApi.default[:username],
            password: settings[:password] || OUApi.default[:password] 
              }
            @user = OUApi::User.new(@login_params)
          end
  
         config.before :each do
            sleep 1
         end
      end
    end
  end#end spec helper

    
end #Runner
end #Ouauto