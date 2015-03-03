module OUApi	
 class User

#=== Auxsite methods =================================================
 	#see /lib/ouapi/json/auxsite.json for the asset api set

 	#---grabs the auxsite set from OUAPi----
 	def users
		OUApi.users
	end
	#-------------------------------------

	#--- create auxsite -------------------
	def create_user(params)
		new_user = users[:new]
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

#======================================================================

end
end