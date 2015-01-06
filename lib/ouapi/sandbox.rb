module OUApi	
 	class Sandbox
 		attr_reader :user
 		include OUApi #see /lib/ouapi/helpers.rb
		def initialize(args)
			if args[:direct_login] != true
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

		def sandbox_variables(args)
			items = {}
			items[:zip] = args[:zip]# || default_zip
			items[:directory_settings] = args[:directory_settings]# || default_directory_settings
			items[:feeds] = args[:feeds]# || default_feeds
			items[:users] = args[:users]# || default_users
			items[:groups] = args[:groups]# || default_groups
			items[:snippet_categories] = args[:snippet_categories]# || default_snippet_categories
			items[:snippets] = args[:snippets]# || dafault_snippets
			items[:template_groups] = args[:template_groups]# || default_templategroups
			items[:assets] = args[:assets]# || default_assets
			items[:gallery] = args[:gallery]# || default_gallery
			items[:news_items] = args[:news_items]# || default_news_items
			items[:auxsites] = args[:auxsites]# || default_auxsites
			items
		end

		def gallena_sandbox(sandbox_hash={})
			items = sandbox_variables(sandbox_hash)		

			#1. Upload the zip file
			@user.zipimport_process(items[:zip])

			#2. Create RSS feed
			process_feeds(items[:feeds])

			#3. Create Aux site
			process_auxsites(items[:auxsites])

			#4. Edit site Access
			

			#5. Create groups
			process_groups(items[:groups])

			#6. create gallery
			process_gallery(items[:gallery])

			#7. create assets
			process_assets(items[:assets])

			#8. create snippets
			process_snippet_categories(items[:snippet_categories])
			process_snippets(items[:snippets])

			#9. Create template groups
			process_template_groups(items[:template_groups])

			#10. Assign directory varaibles
			process_directory_settings(items[:directory_settings])

			#11. Create News Items
			process_news_items(items[:news_items])

			#12. Find and Replace
			process_findandreplace(default_findandreplace)

			#13. Publish Site
			@user.publish_site
		end

		def process_sandbox(hash)
			hash.each do |key,value|
				begin
					send("process_#{key}", value)
				rescue
					puts "The method #{key} is not avaialble."
				end
			end
		end

	end
end