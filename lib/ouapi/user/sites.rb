module OUApi	
 class User

#=== Sites methods =================================================
 	#see /lib/ouapi/json/sites.json for the asset api set

 	#---grabs the sites set from OUAPi----
 	def sites
		OUApi.sites
	end
	#-------------------------------------

	#--- view site -------------------
	def view_site(params={})
		view_site = sites[:view]
		view_site[:params].merge!(params)
		get(view_site)
	end
	#-------------------------------------

	#--- sites publish -------------------
	def publish_site(params={})
		publish = sites[:publish]
		publish[:params].merge!(params)
		post(publish)
	end
	#-------------------------------------

	#--- find and replace ----------------
	def find_and_replace(params)
		findreplace = sites[:findreplace]
		findreplace[:params].merge!(params)
		findreplace[:params][:paths] = findreplace_paths(findreplace[:params][:paths])
		post(findreplace)
	end
	#-------------------------------------

	#--- find and replace status ---------
	def find_and_replace_status(key)
		status = sites[:findreplacestatus]
		status[:params][:id] = key
		get(status)
	end
	#-------------------------------------

	#--- process find and replace---------
	def process_find_and_replace(params)
		response = find_and_replace(params)
		result = json_to_hash(response.body)
		key = result[:id]
		finished = false
		while finished == false
			sleep 2
			response = find_and_replace_status(key)
			result = json_to_hash(response.body)
			puts result[:status]
			finished = result[:finished]
		end
	end
	#-------------------------------------

	#--- paths ---------------------------
	def findreplace_paths(path)
      paths = []
      if path == "/"
  		response = files_list(path:path)
        body = json_to_hash(response.body)
        entries = body[:entries]
        entries.each do |entry|
          paths << entry[:staging_path]
        end
      elsif path.class == Array
          paths = path
      else
        paths << path
      end
      "#{paths}" 
      #returning a stringify version of the string to work correctly with the OUApi.hast_to_query() method
  	end
  	#---------------------------------------

#======================================================================

end
end