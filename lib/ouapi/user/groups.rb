module OUApi	
 class User

#=== Group methods =================================================
 	#see /lib/ouapi/json/groups.json for the asset api set

 	#---grabs the groups set from OUAPi----
 	def groups
		OUApi.groups
	end
	#-------------------------------------

	#--- create asset --------------------
	def create_group(params)
		new_group = groups[:new]
		new_group[:params].merge!(params)
		post(new_group)
	end
	#-------------------------------------

end
end