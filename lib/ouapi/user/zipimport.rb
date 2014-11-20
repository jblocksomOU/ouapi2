module OUApi	
class User
 	
 	def zipimport
 		OUApi.zipimport
	end

	def zipimport_process(params)
		response = zipimport_upload(params)
		#body = json_to_hash(response.body)
		body = JSON.parse(response.body)
		puts body["key"]

		if response.code == "200"
			response = zipimport_extract(body["key"])
			body = json_to_hash(response.body)
			puts response.body
			zipimport_wait(body[:key])
		else
			puts "zip upload failed"
			puts response.body
		end
	end

	def zipimport_upload(args)
		upload = zipimport[:upload]
		params = upload[:params].merge(args[:params])
		file = upload[:file].merge(args[:file])
		package(path:upload[:path],params:params,file:file)
	end 

	def zipimport_extract(key)
		#extract = zipimport[:extract]
		#create(extract,key:key)
		params= {
				key:key,
				site:@site,
				ignore_root:true
			}
		puts params
		response = post(path:"/zipimport/extract",params:params)
		response
	end

	def zipimport_wait(key)
		finished = false
		while finished == false
			response = workers_status(key:key)
			body = json_to_hash(response.body)
			finished == body[:finished]
			if finished == false
				sleep 5
			end
		end
	end

end
end