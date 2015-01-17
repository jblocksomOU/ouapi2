module OUApi	
class Sandbox

	def process_auxsites(data)
		data.each do |item|
			response = @user.create_auxsite(item)
		end
	end

	def process_create_form(data)
		data.each do |item|
			response = @user.create_form(item)
    		puts response.body
		end
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
			response = @user.process_find_and_replace(item)
			sleep 5
		end
	end

	def process_groups(data)
		data.each do |item|
			@user.create_group(item)
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

	def process_gallery(data)
		data.each do |item|
			response = @user.create_gallery(item)
		end
	end

	def process_assets(data)
		data.each do |item|
			@user.create_asset(item)
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

	def process_replace_asset_id(data)
		data.each do |item|
			id = @user.assets_id_by_name(item[:name])
			item[:rplcstr] = id[:asset]
			@user.process_find_and_replace(item)
			sleep 5
		end
	end

	def process_replace_uuid(data)
		uuid = @user.sites_uuid
		@user.process_find_and_replace({srchstr:data[:old_uuid],rplcstr:uuid,paths:["/_resources/php"]})
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
	
	def process_workshop_users(data)
		data.each do |item|
			if item[:password] == "local"
				item[:password] = @user.password
			end
			@user.create_user(item)
		end
	end

	def process_workshop_fontsizesets
		data.each do |item|
			@user.create_fonsizeset(item)
		end
	end

	def process_workshop_toolbars
		data.each do |item|
			@user.create_toolbar(item)
		end
	end

#-------------------------------

end
end
