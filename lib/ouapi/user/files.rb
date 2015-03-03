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

	#---upload----------------------------
	def files_upload(args)
		upload = files[:upload]
		params = upload[:params].merge(args[:params])
		file = upload[:file].merge(args[:file])
		package(path:upload[:path],params:params,file:file)
	end
	#-------------------------------------
end
end

#/files/upload This has to be special