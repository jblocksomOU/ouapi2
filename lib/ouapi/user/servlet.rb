module OUApi	
 class User

#=== Sites methods =================================================
 	#see /lib/ouapi/json/sites.json for the asset api set

 	#---grabs the sites set from OUAPi----
 	def servlet
		OUApi.servlet
	end
	#-------------------------------------

	#-----Get the ldp regfile----------------------------
	def get_ldpregfile(params={})
		ldp = servlet[:ldpregfile]
		ldp[:params].merge!(params)
		get_w_cookie(ldp)
	end
	#----------------------------------------------------


#====================================================================

	end#end class
end#end module