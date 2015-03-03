module OUApi	
 	class Sandbox
 		attr_reader :user
 		include OUApi #see /lib/ouapi/helpers.rb

 		#---- The Sandbox Class---------------------------
 		# Logs in via SuperAdmin or Regular.
 		# Regular Login: It will log into the target site, and does nothing else.
 		# requires the same hash used to initialize the User class.
 		#
 		# SuperAdmin login: It will login into superadmin (credentials entered into console), Create and account, site, and user.
 		# requies the hash that coorespond to the Superadmin class default_account. 
 		#-------------------------------------------------
		def initialize(args)
			if args[:superadmin] == true
				skin = {host: args[:host],skin: args[:skin]}
				@superadmin = OUApi::Superadmin.new(skin)  			
				params = {account:args[:account],site:args[:site],user:args[:user]}
				@superadmin.default_account(params)
				settings = site_settings(args)
			else
				settings = args
			end
			@user = OUApi::User.new(settings)
		end
		#----------------------------------------------

		#--- site settings-----------------------------
		# Organinzes the site data into a hash usable by the User Class. Used in initialization.
		#----------------------------------------------
		def site_settings(args)
			settings = {
				host: args[:host],
				skin: args[:skin],
				account: args[:account][:name],
				username: args[:user][:username],
				password: args[:user][:password],
				site: args[:site][:name]
			}
		end 
		#-----------------------------------------------


		#----process_sandbox------------------------------------
		# Takes a hash of mostly arrays of hashes. The name corresponds to the hash key appended with "process_". 
		# The "process_" addition is for security, so only methods with the name "proccess_" can be used. 
		# If the key fails, or the method it calls fails, then the item will be skipped, and the process will continue.
		# Example: {item:[{data:"data"}, another:[{test:"test"}]], in the example, the process_item method will be called, and the array [{data:"data"}] will be passed to the method. 
		# After that process_item will be called
		#-------------------------------------------------------
		def process_sandbox(hash)
			hash.each do |key,value|
				begin
					send("process_#{key}", value)
				rescue
					puts "The method #{key} failed"
					puts "#{$!}"
				end
			end
		end
		#--------------------------------------------------------

	end
end