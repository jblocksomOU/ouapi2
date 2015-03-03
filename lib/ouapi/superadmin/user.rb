module OUApi	
class Superadmin
 	
	#---grabs the asset set from OUAPi----
 	def user
 		OUApi.superadmin_user
	end
	#-------------------------------------

	#--- create account --------------------
	#-- Grabs the default :new account params from the default value, and merges the user values into it. 
	#-- If name is no privided, then the name will be a random string
	#-- params  - a hash of create account params. see the account api set :new
	def create_user(params={name:random_string})
		new_user = user[:new]
		new_user[:params].merge!(params)
		post(new_user)
	end
	#-------------------------------------

	def view_user(params)
		settings = users[:view]
		settings[:params].merge!(params)
		get(settings)
	end

	def update_user(params)
		response = view_user(params)
		previous = json_to_hash(response.body)
		update = previous.merge(params)
		
		updater = users[:save]
		updater[:params] = update

		post(updater)
	end

end
end