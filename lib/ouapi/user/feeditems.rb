module OUApi	
 class User

#=== RSS methods =================================================
 	#see /lib/ouapi/json/assets.json for the asset api set

 	#---grabs the asset set from OUAPi----
 	def feeditems
		OUApi.feeditems
	end
	#-------------------------------------

	#--- create asset --------------------
	def create_feeditem(params)
		new_item = feeditems[:new]
		new_item[:params].merge!(params)
		post(new_item)
	end
	#-------------------------------------

end
end