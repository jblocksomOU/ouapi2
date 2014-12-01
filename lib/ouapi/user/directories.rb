module OUApi	
class User
 	def directories
 		OUApi.directories
	end

	def directory_settings(params)
		setting = directories[:settings]
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

end
end