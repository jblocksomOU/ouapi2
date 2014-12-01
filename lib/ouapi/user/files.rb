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
end
end

#/files/upload This has to be special