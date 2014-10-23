module OUApi
module Helpers	

#--hash to query string----------------------------------------
		# Turns a hash to a url query string to be used with @http
		# Takes: hash of values
		# Returns: a url query string of the values
		# e.g. {one:"one",two:"two"}  => one=one&two=two
		def hash_to_querystring(params) #Hash to Query String
    		res = ""
      		params.each { |key,val|
        		if val.kind_of?(Array)
          			val.each {|v|
            			res << "#{key}=#{v}&"
         			}
        		else
          		res << "#{key}=#{val}&"
        	end        
      		}
      		res
		end
#---------------------------------------------------------------

end#end Helpers
end#OUAPI