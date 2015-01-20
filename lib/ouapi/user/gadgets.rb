module OUApi	
 class User

#=== Group methods =================================================
 	#see /lib/ouapi/json/gadgets.json for the asset api set

 	#---grabs the groups set from OUAPi----
 	def gadgets
		OUApi.gadgets
	end
	#-------------------------------------

	#--- create asset --------------------
	def create_gadget(params)
		new_gadget = gadgets[:new]
		new_gadget[:params].merge!(params)
		post(new_gadget)
	end
	#-------------------------------------

	#--- create asset --------------------
	def gadgets_list
		gadgets = gadgets[:list]
		post(gadgets)
	end
	#-------------------------------------

end
end