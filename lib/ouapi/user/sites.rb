module OUApi	
 class User

#=== Sites methods =================================================
 	#see /lib/ouapi/json/sites.json for the asset api set

 	#---grabs the sites set from OUAPi----
 	def sites
		OUApi.sites
	end
	#-------------------------------------

	#--- update site ---------------------
	def update_site(params)
		response = view_site
		previous = json_to_hash(response.body)
		update = previous.merge(params)
		
		updater = sites[:save]
		updater[:params] = update

		#stuff that is in update that is not returned by view_site. I will need to find a better approach
		#updater[:params][:authtype] = params[:authtype] || 0
		#updater[:params][:ftp_type] = params[:ftp_type] || 0
		#updater[:params][:home_path] = params[:home_path] || "/"
		#updater[:params][:id] = @account
		#updater[:params][:template_location] = params[:template_location] || 0

		post(updater)
	end
	#-------------------------------------

	#-------------------------------------
	def create_site(params)
		new_site = sites[:new]
		params[:site] = params[:name]
		new_site[:params].merge!(params)
		new_site[:params][:address] = append_ftp_value(new_site[:params][:address],new_site[:params][:ftp_type])
		post(new_site)
	end
	#-------------------------------------

	#--- view site ----------------------
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

	#--- initialize site------------------
	def initialize_site(params={})
		init = sites[:init]
		init[:params].merge!(params)
		post(init)
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
		response
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

  	#---last-find-replace-------------------
  	def lastfindreplace
  		last = sites[:lastfindreplace]
		get(last)
  	end

  	#----------------------------------------

  	#---get uuid----------------------------
  	def sites_uuid
  		response = view_site
    	site = json_to_hash(response.body)
    	uuid = site[:uuid]
    	uuid
    end
  	#---------------------------------------

  	#---get uuid----------------------------
  	def sites_creds(params={})
  		response = view_site(params)
    	site = json_to_hash(response.body)
    	creds = {address:site[:address],password:site[:password]}
    end
  	#---------------------------------------

#======================================================================

end
end