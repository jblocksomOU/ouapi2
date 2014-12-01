module OUApi	
 class User

#=== Group methods =================================================
 	#see /lib/ouapi/json/templategroups.json for the asset api set

 	#---grabs the tempaltegroups set from OUAPi----
 	def templategroups
		OUApi.templategroups
	end
	#-------------------------------------

	#--- create asset --------------------
	def create_template_group(params)
		new_group = templategroups[:new]
		new_group[:params].merge!(params)
		post(new_group)
	end
	#-------------------------------------
#==================================================================

end
end