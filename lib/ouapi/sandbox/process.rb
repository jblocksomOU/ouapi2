module OUApi	
class Sandbox

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

	def process_templategroups(data)
		@user.list_templates({})#needed, the templates list has to be initialized before they can be assigned to any groups
		data.each do |item|
			response = @user.create_template_group(item)
		end
	end

	def process_gallery(data)
		data.each do |item|
			response = @user.create_gallery(item)
			result = json_to_hash(response.body)
			@gallery_id = result[:asset]
		end
	end

	def process_assets(data)
		data.each do |item|
			@user.create_asset(item)
		end
	end

	def process_news_items(data)
		data.each do |item|
			response = @user.create_template(item)
		end
	end

	def process_auxsites(data)
		data.each do |item|
			response = @user.create_auxsite(item)
		end
	end

	def process_findandreplace(data)
		data.each do |item|
			response = @user.process_find_and_replace(item)
			sleep 5
		end
	end

end
end
