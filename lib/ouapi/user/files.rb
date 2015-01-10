module OUApi	
class User
 	def files
 		OUApi.files
	end

	#--- create asset --------------------
	def files_list(params)
		list = files[:list]
		list[:params].merge!(params)
		get(list)
	end
	#-------------------------------------

	#---multi-publish---------------------
	def files_multipublish(params)
		multi = files[:multipublish]
		multi[:params].merge!(params)
		post(multi)
	end
	#-------------------------------------
end
end

#/files/upload This has to be special