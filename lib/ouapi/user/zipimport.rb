module OUApi	
class User
 	
 	def zipimport
 		OUApi.zipimport
	end

	def zipimport_process(params)
		puts "uploading: #{params[:file][:path]}"
		response = zipimport_upload(params)
		body = json_to_hash(response.body)

		if response.code == "200"
			response = zipimport_extract(body[:key])
			body = json_to_hash(response.body)
			zipimport_wait(body[:key])
			if response.code == "400"
				response = zipimport_extract(body[:key])
				body = json_to_hash(response.body)
				zipimport_wait(body[:key])
			end
		else
			puts "zip upload failed"
			puts response.body
		end
	end

	def zipimport_upload(args)
		upload = zipimport[:upload]
		params = upload[:params].merge(args[:params])
		file = upload[:file].merge(args[:file])
		package_w_cookie(path:upload[:path],params:params,file:file)
	end 

	def zipimport_extract(key)
		extract = zipimport[:extract]
		extract[:params].merge!(key:key)	
		post_w_cookie(extract)
	end

	def zipimport_wait(key)
		finished = false
		while finished == false
			response = workers_status(key:key)
			body = json_to_hash(response.body)
			puts body
			if body[:finished] == false
				finished = false
			else
				finished = true
			end
			sleep 5
		end
	end

end
end