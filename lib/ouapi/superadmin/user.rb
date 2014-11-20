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
		create(new_user,params)
	end
	#-------------------------------------
end
end