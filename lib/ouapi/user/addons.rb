module OUApi	
 class User

#=== Addons methods =================================================
 	#see /lib/ouapi/json/user/addons.json for the asset api set

	 	#---grabs the asset set from OUAPi----
	 	def addons
			OUApi.addons
		end
		#-------------------------------------

		#--- create asset --------------------
		#-- Grabs the default :new asset params from the default value, and merges the user values into it. 
		#-- If not name id privided, then the name will be a random string
		#-- params  - a hash of create asset params. see the asset api set :new
		def create_addon(params)
			new_addon = addons[:new]
			new_addon[:params].merge!(params)
			post(new_addon)
		end
		#-------------------------------------
		
	end#end User
end#end OUApi