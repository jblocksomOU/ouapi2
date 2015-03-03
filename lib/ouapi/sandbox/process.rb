module OUApi	
class Sandbox

	#---Processes---------------------------
	# These are methods that represent a single action. They take an array of hashes, and which allows the user to send multiple items to the method.
	# Most item are straight foward, however some require special procedures. Which is why there is a method for each process.
	#---------------------------------------

	def process_access_asset_settings(data)
		data.each do |item|
			@user.update_access_asset_settings(item)
		end
	end

	def process_addons(data)
		data.each do |item|
			@user.create_addon(item)
		end
	end

	def process_assets(data)
		data.each do |item|
			@user.create_asset(item)
		end
	end

	def process_auxsites(data)
		data.each do |item|
			@user.create_auxsite(item)
		end
	end

	def process_create_form(data)
		data.each do |item|
			@user.create_form(item)
		end
	end

	def process_create_site(data)
		@user.create_site(data)
	end

	def process_create_sandbox_site(data)
		process_create_site(data)
		@user.change_site(data[:name])
		sleep 5
	end

	def process_directory_settings(data)
		data.each do |item|
			@user.update_directory_settings(item)
		end
	end

	def process_feeds(data)
		data.each do |item|
			@user.create_feed(item)
		end
	end

	def process_feeditems(data)
		data.each do |item|
			@user.create_feeditem(item)
		end
	end

	def process_findandreplace(data)
		data.each do |item|
			@user.process_find_and_replace(item)
			sleep 10
		end
	end

	def process_fontsizesets(data)
		data.each do |item|
			@user.create_fontsizeset(item)
		end
	end

	def process_gallery(data)
		data.each do |item|
			@user.create_gallery(item)
		end
	end

	def process_groups(data)
		data.each do |item|
			@user.create_group(item)
		end
	end

	def process_news_items(data)
		data.each do |item|
			@user.create_template(item)
		end
	end

	def process_publish_assets(data)
		@user.assets_publish_all
	end

	def process_publish_site(data)
		@user.publish_site(data)
	end

	#--- Replace Asset id --------------
	# Used for Sandboxes. Takes the existing id used by the old files.
	# Finds the asset id of the asset specified by #name.
	# And replaces it with the old id
	#-----------------------------------
	def process_replace_asset_id(data)
		data.each do |item|
			id = @user.assets_id_by_name(item[:name])
			if id
				item[:rplcstr] = id[:asset]
				puts item
				response = @user.process_find_and_replace(item)
				@user.lastfindreplace
				sleep 5
			else
				puts "asset name #{item[:name]} does not exist"
			end
		end
	end
	#-----------------------------------

	#---- Replace uuid------------------
	# Takes the old uuid, gets the exsiting uuid from site settings, and replaces it with the old
	#-----------------------------------
	def process_replace_uuid(data)
		uuid = @user.sites_uuid
		@user.process_find_and_replace({srchstr:data[:old_uuid],rplcstr:uuid,paths:["/_resources"]})
		@user.lastfindreplace
	end
	#-----------------------------------

	#---- Replace site name for forms------------------
	# Replace site name in the form file
	#--------------------------------------------------
	def process_replace_site_uuid(data)
		search = data[:old_sitename]+" =>"
		sitename = @user.site
		site = "#{sitename}\" =>"
		@user.process_find_and_replace({srchstr:search,rplcstr:site,paths:["/_resources"]})
		@user.lastfindreplace
	end
	#-----------------------------------

	def process_scan_site(data)
		data.each do |item|
			@user.scan_site(item)
		end
	end

	def process_snippet_categories(data)
		data.each do |item|
			@user.create_snippet_category(item)
		end
	end

	def process_snippets(data)
		data.each do |item|
			@user.create_snippet(item)
		end
	end

	def process_template_groups(data)
		@user.list_templates({})#needed, the templates list has to be initialized before they can be assigned to any groups
		data.each do |item|
			response = @user.create_template_group(item)
		end
		@user.templategroup_list #needed, the groups need to be initialized
	end

	def process_toolbars(data)
		data.each do |item|
			@user.create_toolbar(item)
		end
	end

	def process_upload_to_production(data)
		data.each do |item|
			if item[:params][:target] == "production"
				item[:params][:target] = @user.site
			end		
			@user.files_upload(item)
		end
	end

	def process_users(data)
		data.each do |item|
			@user.create_user(item)
		end
	end

	def process_zip(data)
		@user.zipimport_process(data)
	end



#---Workshop related items------

	#--- use common password ---
	# Speicial procedure for the workshop sandbox. Creates users with the same password as the user that is currently logged in.
	#---------------------------
	def process_workshop_users(data)
		data.each do |item|
			if item[:password] == "local"
				item[:password] = @user.password
			end
			@user.create_user(item)
		end
	end
	#--------------------------
#-------------------------------

end
end
