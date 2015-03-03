module OUApi	
 class User

#=== Group methods =================================================
 	#see /lib/ouapi/json/groups.json for the asset api set

 	#---grabs the groups set from OUAPi----
 	def snippets
		OUApi.snippets
	end
	#-------------------------------------

	#--- create category --------------------
	def create_snippet_category(params)
		new_cat = snippets[:addcategory]
		new_cat[:params].merge!(params)
		post(new_cat)
	end
	#-------------------------------------

	#--- create snippet ------------------
	def create_snippet(params)
		params[:snippet] = params[:name]
		new_snippet = snippets[:addsnippet]
		new_snippet[:params].merge!(params)
		post(new_snippet)
	end
	#-------------------------------------

end
end