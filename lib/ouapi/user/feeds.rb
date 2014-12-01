module OUApi	
 class User

#=== RSS methods =================================================
 	#see /lib/ouapi/json/assets.json for the asset api set

 	#---grabs the asset set from OUAPi----
 	def feeds
		OUApi.feeds
	end
	#-------------------------------------

	#--- create asset --------------------
	def create_feed(params)
		new_feed = feeds[:new]
		new_feed[:params].merge!(params)
		post(new_feed)
	end
	#-------------------------------------

end
end