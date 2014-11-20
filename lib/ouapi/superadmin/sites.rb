module OUApi	
class Superadmin
 	
	#---grabs the asset set from OUAPi----
 	def site
 		OUApi.superadmin_site
	end
	#-------------------------------------

	#--- create account --------------------
	#-- Grabs the default :new account params from the default value, and merges the user values into it. 
	#-- If name is no privided, then the name will be a random string
	#-- params  - a hash of create account params. see the account api set :new
	def create_site(params={name:random_string})
		new_site = site[:new]
		params[:site] = params[:name]
		create(new_site,params)
	end
	#-------------------------------------
end
end