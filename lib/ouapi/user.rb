module OUApi	
 	class User
 		attr_reader :host,:skin,:account,:site,:username,:userlevel,:token,:password
 		include OUApi #see /lib/ouapi.rb
		def initialize(args={})	

			#inital parameters
			@host = args[:host]
	        @skin = args[:skin]
	        @account = args[:account]
	        @site = args[:site]
	        @username = args[:username]
	        @password = args[:password]
	        @userlevel = args[:userlevel] || 10
	        @cookies = ""
	        @cookie_array = []
	        @token = ""
	        @http  = Net::HTTP.new(@host)
	        
	        #login, get/set token
	      	login #use http and a cookie to log in
	      	set_token # once login is confirmed, then set the cookie for the session
		end

#===login methods===========================================		
		#----Login--------------------------------------------------
		# Makes a request to /authentication/whoami to recieve a cookie
		# Checks if the host is valid, if not reports and aborts
		# Sets the cookie, and tries to log in. Sends login checking to the method login_check
		def login
			response = @http.get("/authentication/whoami")
	        if(response.code == '200')
	          set_cookie(response)
	          puts ""
	          puts "--------"
	          puts "login"
	          login_response = @http.post("/authentication/login","username=#{@username}&password=#{@password}&skin=#{@skin}&account=#{@account}",{'Cookie' => @cookies.to_s})
	          check_cookie(login_response)
	          login_check(login_response)
	          puts "--------"
	          puts ""
	        else
	          puts "Error invalid host #{response.message}"
	          abort #if the login site is invalid, then abort
	        end      
		end
		#-----------------------------------------------------------

		#---login check-------------------------------------------
		# Takes the response from /authentication/login
		# checks if the response is 200 or not, if not then reports and aborts
		def login_check(response)
			if response.code == '200'
				puts "#{response.code} - #{response.message}: Logged in"
				puts "site: #{api_location}"
				puts "with: #{username}"
			else
				puts "#{response.code} - #{response.body}: Failed to log in"
				abort #if login fails, then abort
			end
		end
		#-----------------------------------------------------------

		def api_location
			"#{host}/10/##{skin}/#{account}/#{site}"
		end
#=================================================================

#==== authenication methods=======================================
	#----set cookie-------------------------------------
	# Gets the cookie from the response and sets it.
	# The cookie is set to the class varaible @cookies 
	def set_cookie(response)
		test_cookie = response.get_fields('set-cookie')

		if @cookie_array.include? test_cookie
			@cookies
		else
			@cookie_array << test_cookie
   			@cookies = @cookie_array.join('; ')
   		end
		#@cookies = response.get_fields('set-cookie')
	end
	#--------------------------------------------------

	#---- Checks if there is a new cookie, if so then update it.----
		# Takes the response from @http, checks if the object has a cookie, if so then sets it to @cookies
		def check_cookie(response)
			   if response.get_fields('set-cookie')
        			set_cookie(response)
        			print "new cookie: "
        			puts response.get_fields('set-cookie')
        			puts @cookies
        		end
		end
	#---------------------------------------------------------------

	#---set token-------------------------------------------------------
	# Makes a call to the /gadgets/list call, get the first item in the list, and grabs the token
	# Sets the token to the class variable #token
	# Returns the token string
	def set_token
		puts "---------"
		response = @http.get("/gadgets/list?account=#{@account}",cookie_hash)#needed for the case of new user. The list has to be initialized before it can be accessed.
		check_cookie(response)
		puts "---------"
		sleep 2
		puts ""
		puts "---------"
		response2 = @http.get("/gadgets/list?context=sidebar&active=true&account=#{@account}",cookie_hash)
		check_cookie(response2)
		puts "---------"
		puts ""
		gadgets = JSON.parse(response.body)
		token = gadgets.first["token"]
		@token = token
	end
	#--------------------------------------------------
#=================================================================

#=== get and post methods ========================================
		# path = api path, the host implied e.g. /files/list
		# params = the parameters for the api. Token,site,and account defaulted. Adding parameter will override default.
		# Note: The basic get and post are using the token to make request. The use of the cookie requires cookie juggling when make multiple request to the cluster on cms.
		# Returns: The http response.
		#---------------------------------------------------------------
		def get(api)
			validate_api(api)
			params = set_default_params(api[:params])
			query = hash_to_querystring(params)
			url = "#{api[:path]}?#{query}"
			response = @http.get(url)
			check_cookie(response)
			puts "#{response.code} - #{response.message}: #{api[:path]} "
			response
		end
		#---------------------------------------------------------------
		
		#---------------------------------------------------------------
		def post(api)
			validate_api(api)
			params = set_default_params(api[:params])
			query = hash_to_querystring(params)
			response = @http.post(api[:path],query)
			check_cookie(response)
			puts "#{response.code} - #{response.message}: #{api[:path]} "
			response
		end
		#-----------------------------------------------------------

		#---package prepares a file to be uploaded------------------------------------------
		# Takes a hash {:path,:params,:file} 
		# path is api url
		# params is a api parameters for the upload
		# file contains the path,name,type of file to be uploaded.
		#  path - path to the file, name(optional) - use if the file is not renamed during upload, type(optional) [img,binary]- determins if the file is  binary or not, if not declared then the ext is checked. 
		def package(api)
			params = set_default_params(api[:params])
			query = hash_to_querystring(params)
			path = "#{api[:path]}?#{query}"

			name = api[:file][:name] || api[:file][:path]
			file = api[:file][:path]
			type = api[:file][:type] || upload_type(file)
			content_type = api[:file][:content_type] || "text/html"
			
			if (type == "img" || type == "binary")
				document = File.binread(file)
			else 
				document = File.read(file)
			end

			boundary = "xx#{random_string}xx"
			post_body = []
			post_body << "--#{boundary}\r\n"
			post_body << "Content-Disposition: form-data; name=\"#{name}\"; filename=\"#{File.basename(file)}\"\r\n"
			post_body << "Content-Type: #{content_type}\r\n"
			post_body << "\r\n"
			post_body <<  document
			post_body << "\r\n--#{boundary}--\r\n"

			request = Net::HTTP::Post.new(path)
			request.body = post_body.join

			request["Content-Type"] = "multipart/form-data, boundary=#{boundary}"
			response = @http.request(request)
			check_cookie(response)
			puts "#{response.code} - #{response.message}: #{api[:path]} #{name}"
			response
		end
		#------------------------------------------------------------------------

		def upload_type(file)
			ext = File.extname(file)
			non_binary = %w[.pcf .tcf .tmpl .xml .php .txt .asp .aspx .html]
			if non_binary.include?(ext)
				return "non_binary"
			else
				return "binary"
			end
		end

		#---set default params------------------------------------------
		# Sets default params for the api request for ease of use
		# The default value is used unless an explict value is passed
		# The default values are the values that were used to initalize the api session
		# Returns: Altered hash of the given parameters
		def set_default_params(params)
			params[:authorization_token] = @token
			params[:account] = params[:account] || @account
			
			if params[:site] == "ignore"
				params.delete(:site)
			else
				params[:site] = params[:site] || @site
			end
			
			if params[:user] == "account" #special case for the servlet calls. The user parameter is the the account name
				params[:user] = @account
			end
			
			params
		end
		#---------------------------------------------------------------

		#--- Create-------------------------------------------
		def create(api,params)
			query = api
			query[:params].merge!(params)
			post(query)
		end
		#-----------------------------------------------------

		#--- Read---------------------------------------------
		def read(api,params)
			query = api
			query[:params].merge!(params)
			get(query)
		end
		#-----------------------------------------------------
#===========================================================

#=== get and post methods with cookie ========================================
		# path = api path, the host implied e.g. /files/list
		# params = the parameters for the api. No defaults set for the cookie only methods.
		# Note: Adding the cookie method for situations where the cookie might be needed.
		# Returns: The http response.
		#---------------------------------------------------------------
		def get_w_cookie(api)
			params = set_default_params_w_cookie(api[:params])
			query = hash_to_querystring(params)
			url = "#{api[:path]}?#{query}"
			response = @http.get(url,cookie_hash)
			puts "#{response.code} - #{response.message}: #{api[:path]} "
			check_cookie(response)
			response
		end
		#---------------------------------------------------------------
		
		#---------------------------------------------------------------
		def post_w_cookie(api)
			params = set_default_params_w_cookie(api[:params])
			query = hash_to_querystring(params)
			response = @http.post(api[:path],query,cookie_hash)
			puts "#{response.code} - #{response.message}: #{api[:path]} "
			check_cookie(response)
			response
		end
		#-----------------------------------------------------------

		#---package prepares a file to be uploaded------------------------------------------
		# Takes a hash {:path,:params,:file} 
		# path is api url
		# params is a api parameters for the upload
		# file contains the path,name,type of file to be uploaded.
		#  path - path to the file, name(optional) - use if the file is not renamed during upload, type(optional) [img,binary]- determins if the file is  binary or not, if not declared then the ext is checked. 
		def package_w_cookie(api)
			params = set_default_params(api[:params])
			query = hash_to_querystring(params)
			path = "#{api[:path]}?#{query}"

			name = api[:file][:name] || api[:file][:path]
			file = api[:file][:path]
			type = api[:file][:type] || upload_type(file)
			content_type = api[:file][:content_type] || "text/html"
			
			if (type == "img" || type == "binary")
				document = File.binread(file)
			else 
				document = File.read(file)
			end

			boundary = "xx#{random_string}xx"
			post_body = []
			post_body << "--#{boundary}\r\n"
			post_body << "Content-Disposition: form-data; name=\"#{name}\"; filename=\"#{File.basename(file)}\"\r\n"
			post_body << "Content-Type: #{content_type}\r\n"
			post_body << "\r\n"
			post_body <<  document
			post_body << "\r\n--#{boundary}--\r\n"

			request = Net::HTTP::Post.new(path,cookie_hash)
			request.body = post_body.join

			request["Content-Type"] = "multipart/form-data, boundary=#{boundary}"
			response = @http.request(request)
			check_cookie(response)
			puts "#{response.code} - #{response.message}: #{api[:path]} #{name}"
			response
		end
		#------------------------------------------------------------------------

		#---set default params with cookie------------------------------------------
		# Sets default params for the api request for ease of use for the cookie methods
		# The default value is used unless an explict value is passed
		# The default values are the values that were used to initalize the api session
		# Returns: Altered hash of the given parameters
		def set_default_params_w_cookie(params)
			params[:account] = params[:account] || @account
			params[:site] = params[:site] || @site
			params
		end
		#---------------------------------------------------------------

#===========================================================

#==Post/Get Helpers=========================================
		#---cookie hash--------------------------------------------
		# Takes the class varaible cookies
		# Puts the cookie into a format that will work with @http
		def cookie_hash
			{ 'Cookie' => @cookies.to_s }
		end
		#---------------------------------------------------------------

		def validate_api(api)
			api[:path] ? "" : abort("path required")
		end
#===========================================================
	end#end class

end#end module