module OUApi	
 class User

#=== Auxsite methods =================================================
 	#see /lib/ouapi/json/auxsite.json for the asset api set

 	#---grabs the auxsite set from OUAPi----
 	def account
		OUApi.account
	end
	#-------------------------------------

	def view_account(params)
		settings = account[:view]
		settings[:params].merge!(params)
		get(settings)
	end

	def update_account(params)
		response = view_account(params)
		previous = json_to_hash(response.body)
		update = previous.merge(params)
		
		updater = account[:save]
		updater[:params] = update
		post(updater)
	end

#======================================================================

end
end