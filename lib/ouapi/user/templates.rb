module OUApi	
 class User

#=== Group methods =================================================
 	#see /lib/ouapi/json/templates.json for the asset api set

 	#---grabs the groups set from OUAPi----
 	def templates
		OUApi.templates
	end
	#-------------------------------------

	#----new page via template--------------
	def create_template(params)
		new_template = templates[:new]
		new_template[:params].merge!(params)
		post(new_template)
	end
	#--------------------------------------

	#--- list templates --------------------
	def list_templates(params={})
		list = templates[:list]
		list[:params].merge!(params)
		get(list)
	end
	#-------------------------------------

end
end