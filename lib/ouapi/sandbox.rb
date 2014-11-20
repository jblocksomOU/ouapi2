module OUApi	
 	class Sandbox
 		
 		include OUApi #see /lib/ouapi/helpers.rb
		def initialize(args)
			if args[:direct_login] != true
				skin = {host: args[:host],skin: args[:skin]}
				@superadmin = OUApi::Superadmin.new(skin)  
				
				params = {account:args[:account],site:args[:site],user:args[:user]}
				@superadmin.default_account(params)
				
				settings = {host: args[:host],skin: args[:skin],account: args[:account][:name],username: args[:user][:username],password: args[:user][:password],site: args[:site][:name]}
			else
				settings = args
			end
			@user = OUApi::User.new(settings)
		end

	end
end