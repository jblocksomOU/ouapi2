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

#======================================================================

end
end