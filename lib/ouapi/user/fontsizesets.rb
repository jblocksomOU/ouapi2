module OUApi	
 class User

#=== Group methods =================================================
 	#see /lib/ouapi/json/groups.json for the asset api set

 	#---grabs the groups set from OUAPi----
 	def fontsizesets
		OUApi.fontsizesets
	end
	#-------------------------------------

	#--- create asset --------------------
	def create_fontsizeset(params)
		new_font = fontsizesets[:new]
		new_font[:params].merge!(params)
		post(new_font)
	end
	#-------------------------------------

end
end