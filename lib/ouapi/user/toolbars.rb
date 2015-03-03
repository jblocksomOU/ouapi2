module OUApi	
 class User

#=== Group methods =================================================
 	#see /lib/ouapi/json/groups.json for the asset api set

 	#---grabs the groups set from OUAPi----
 	def toolbars
		OUApi.toolbars
	end
	#-------------------------------------

	#--- create asset --------------------
	def create_toolbar(params)
		new_tool = toolbars[:new].clone
		new_tool[:params].merge!(params)
		post(new_tool)
	end
	#-------------------------------------

end
end