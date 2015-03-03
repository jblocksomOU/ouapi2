module OUApi	
class Superadmin
 	
	#---grabs the asset set from OUAPi----
 	def accounts
 		OUApi.superadmin_account
	end
	#-------------------------------------

	#--- create account --------------------
	#-- Grabs the default :new account params from the default value, and merges the user values into it. 
	#-- If name is no privided, then the name will be a random string
	#-- params  - a hash of create account params. see the account api set :new
	def create_account(params={name:random_string})
		new_accounts = accounts[:new]
		new_accounts[:params].merge!(params)
		post(new_accounts)
	end
	#-------------------------------------

end
end