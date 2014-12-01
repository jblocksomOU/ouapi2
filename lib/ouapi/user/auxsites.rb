module OUApi	
 class User

#=== Auxsite methods =================================================
 	#see /lib/ouapi/json/auxsite.json for the asset api set

 	#---grabs the auxsite set from OUAPi----
 	def auxsites
		OUApi.auxsites
	end
	#-------------------------------------

	#--- create auxsite -------------------
	def create_auxsite(params)
		new_auxsite = auxsites[:new]
		new_auxsite[:params].merge!(params)
		new_auxsite[:params][:address] = append_ftp_value(new_auxsite[:params][:address],new_auxsite[:params][:ftp_type])
		post(new_auxsite)
	end
	#-------------------------------------

#======================================================================

end
end