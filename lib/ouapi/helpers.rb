module OUApi
module Helpers	

#--hash to query string----------------------------------------
		# Turns a hash to a url query string to be used with @http
		# Takes: hash of values
		# Returns: a url query string of the values
		# e.g. {one:"one",two:"two"}  => one=one&two=two
		def hash_to_querystring(params) #Hash to Query String
    		  res = ""
          params = escape_hash(params) 
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

    def random_string(len = 10)
        o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
        string = (0...len).map { o[rand(o.length)] }.join
    end

    def json_to_hash(response)
      JSON.parse(response,:symbolize_names => true)
    end

#---Methods to help with testing--------------------------------
    def prep_params(api)
      api[:params].each { |key, value| 
        if value == "random"
          api[:params][key] = random_string
        end
      }
    end

    def escape_hash(hash_values) 
    encoded_hash = {}
    hash_values.each do |key,value|
        if value.class == String #non string values can be passed into the parameters. The encoding only needs to be performed on Sting objects. 
          value = CGI::escape value
        end
        encoded_hash[:"#{key}"] = value
     end
    encoded_hash
  end

end#end Helpers
end#OUAPI