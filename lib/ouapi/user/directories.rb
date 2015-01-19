module OUApi	
class User
 	def directories
 		OUApi.directories
	end

	def directory_settings(params)
		setting = directories[:settings]
		read(setting,params)
	end

	def access_asset_settings(params={})
		setting = directories[:asset_settings]
		read(setting,params)
	end

	def update_directory_settings(params)
		response = directory_settings(path:params[:path])
		previous = json_to_hash(response.body)
		update = previous.merge(params)
		
		updater = directories[:update_settings]
		updater[:params] = update

		post(updater)
	end

	def update_access_asset_settings(params)
		response = access_asset_settings
		previous = json_to_hash(response.body)
		update = previous.merge(params)
		
		updater = directories[:update_access_asset_settings]
		updater[:params].merge!(update)
		post(updater)
	end

end
end