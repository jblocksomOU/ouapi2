module OUApi	
 	class Superadmin
 		include OUApi #allows direct access to OUApi methods
 		attr_reader :host,:skin,:username

		def initialize(args={},default_login=false)	
			#inital parameters
			@host = args[:host] || OUApi.default[:host] 
	        @skin = args[:skin] || OUApi.default[:skin]

	        login_options(default_login)
   
	        @cookie = ""
	        @http  = Net::HTTP.new(@host)
	        
	        #login, get/set token
	      	login #use http and a cookie to log in
	      	#set_token #I want to use a token, but I do not think there is a superadmin version
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
	          login_response = @login_response = @http.post("/authentication/admin_login","username=#{@username}&password=#{@password}&skin=#{@skin}",{'Cookie' => @cookies.to_s})
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
				puts "#{response.code} - #{response.message} : Logged in"
			else
				puts "#{response.code} - #{response.body} : Failed to log in"
				abort #if login fails, then abort
			end
		end
		#-----------------------------------------------------------

		def login_options(default_login)
			if default_login == true
	        	@usernmae = args[:username] || OUApi.default[:username]
	        	@password = args[:password] || OUApi.default[:password] 
	        	puts "test"
	        else
        		puts "Enter username:"
        		@username = gets.chomp
        		puts "Enter password:"
       			@password = STDIN.noecho(&:gets).chomp
       		end
		end

		#----set cookie-------------------------------------
		# Gets the cookie from the response and sets it.
		# The cookie is set to the class varaible @cookies 
		def set_cookie(response)
			@cookies = response.get_fields('set-cookie')
		end
		#--------------------------------------------------
#=============================================================================


#=== get and post methods with cookie ========================================
		# path = api path, the host implied e.g. /files/list
		# params = the parameters for the api. No defaults set for the cookie only methods.
		# Note: Adding the cookie method for situations where the cookie might be needed.
		# Returns: The http response.
		#---------------------------------------------------------------
		def get(args)
			query = hash_to_querystring(args[:params])
			url = "#{args[:path]}?#{query}"
			response = @http.get(url,cookie_hash)
			puts "#{response.code} - #{response.message}: #{args[:path]} "
			check_cookie(response)
			response
		end
		#---------------------------------------------------------------
		
		#---------------------------------------------------------------
		def post(args)
			query = hash_to_querystring(args[:params])
			response = @http.post(args[:path],query,cookie_hash)
			puts "#{response.code} - #{response.message}: #{args[:path]} "
			check_cookie(response)
			response
		end
		#-----------------------------------------------------------

		#---- Checks if there is a new cookie, if so then update it.----
		# Takes the response from @http, checks if the object has a cookie, if so then sets it to @cookies
		def check_cookie(response)
			   if response.get_fields('set-cookie')
        			set_cookie(response)
        			puts response.get_fields('set-cookie')
        		end
		end
		#---------------------------------------------------------------

		#--- Generic Create Call------------------------------
		def create(api,params)
			query = api
			query[:params].merge!(params)
			post(query)
		end
		#-----------------------------------------------------

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