module OUApi	
 	class User
 		include Helpers #see /lib/ouapi/helpers.rb
 		attr_reader :host,:skin,:account,:site,:username,:token

		def initialize(args={})	

			#inital parameters
			@host = args[:host] || OUApi.default[:host] 
	        @skin = args[:skin] || OUApi.default[:skin]
	        @account = args[:account] || OUApi.default[:account]
	        @site = args[:site] || OUApi.default[:site]
	        @username = args[:username] || OUApi.default[:username]
	        @password = args[:password] || OUApi.default[:password]
	        @cookie = ""
	        @token = ""
	        puts @http
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
	          login_response = @http.post("/authentication/login","username=#{@username}&password=#{@password}&skin=#{@skin}&account=#{@account}",{'Cookie' => @cookies.to_s})
	          login_check(login_response)
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
				puts "logged in: #{response.code} - #{response.message}"
			else
				puts "Failed to log in : #{response.code} - #{response.body}"
				abort #if login fails, then abort
			end
		end
		#-----------------------------------------------------------
#=================================================================

#==== authenication methods=======================================
	#----set cookie-------------------------------------
	# Gets the cookie from the response and sets it.
	# The cookie is set to the class varaible @cookies 
	def set_cookie(response)
		@cookies = response.get_fields('set-cookie')
	end
	#--------------------------------------------------

	#---set token-------------------------------------------------------
	# Makes a call to the /gadgets/list call, get the first item in the list, and grabs the token
	# Sets the token to the class variable #token
	# Returns the token string
	def set_token
		response = @http.get("/gadgets/list?context=sidebar&active=true&account=#{@account}",{'Cookie' => @cookies.to_s})
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
			params = set_default_params(api[:params])
			query = hash_to_querystring(params)
			url = "#{api[:path]}?#{query}"
			@http.get(url)
		end
		#---------------------------------------------------------------
		
		#---------------------------------------------------------------
		def post(api)
			params = set_default_params(api[:params])
			query = hash_to_querystring(params)
			@http.post(api[:path],query)
		end
		#-----------------------------------------------------------

		#---set default params------------------------------------------
		# Sets default params for the api request for ease of use
		# The default value is used unless an explict value is passed
		# The default values are the values that were used to initalize the api session
		# Returns: Altered hash of the given parameters
		def set_default_params(params)
			params[:authorization_token] = params[:authorization_token] || @token
			params[:account] = params[:account] || @account
			params[:site] = params[:site] || @site
			params
		end
		#---------------------------------------------------------------
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
			check_cookie(response)
			response
		end
		#---------------------------------------------------------------
		
		#---------------------------------------------------------------
		def post_w_cookie(api)
			params = set_default_params_w_cookie(api[:params])
			query = hash_to_querystring(params)
			response = @http.post(api[:path],query,cookie_hash)
			check_cookie(response)
			response
		end
		#-----------------------------------------------------------

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

		#---- Checks if there is a new cookie, if so then update it.----
		# Takes the response from @http, checks if the object has a cookie, if so then sets it to @cookies
		def check_cookie(response)
			   if response.get_fields('set-cookie')
        			set_cookie(response)
        			puts response.get_fields('set-cookie')
        		end
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
#===========================================================
	end#end class

end#end module