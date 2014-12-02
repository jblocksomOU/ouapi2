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
			@zip_path = args[:zip] || default_zip
			@user = OUApi::User.new(settings)
			args={}
			sandbox_variables(args)		
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
			@zip_path = args[:zip] || @zip_path
			@directory_settings = args[:directory_settings] || default_directory_settings
			@feeds = args[:feeds] || default_feeds
			@groups = args[:groups] || default_groups
			@snippet_categories = args[:snippet_categories] || default_snippet_categories
			@snippets = args[:snippets] || dafault_snippets
			@templategroups = args[:templategroups] || default_templategroups
			@assets = args[:assets] || default_assets
			@gallery = args[:gallery] || default_gallery
			@news_items = args[:news_items] || default_news_items
			@auxsites = args[:auxsites] || default_auxsites
			#@find_and_replace = default_findandreplace
		end

		def gallena_sandbox
			#1. Upload the zip file
			@user.zipimport_process(@zip_path)

			#2. Create RSS feed
			process_feeds(@feeds)

			#3. Create Aux site
			process_auxsites(@auxsites)

			#4. Edit site Access

			#5. Create groups
			process_groups(@groups)

			#6. create gallery
			process_gallery(@gallery)

			#7. create assets
			process_assets(@assets)

			#8. create snippets
			process_snippet_categories(@snippet_categories)
			process_snippets(@snippets)

			#9. Create template groups
			process_templategroups(@templategroups)

			#10. Assign directory varaibles
			process_directory_settings(@directory_settings)

			#11. Create News Items
			process_news_items(@news_items)

			#12. Find and Replace
			process_findandreplace(default_findandreplace)

			#13. Publish Site
			@user.publish_site
		end

	end
end