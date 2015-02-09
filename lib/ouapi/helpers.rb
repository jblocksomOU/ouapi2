module OUApi

#=== Basic Helper Methods=============
  #---Random String------------------------
  #-- Produces a random string of a-zA-Z characters, defaults to a length of 10
  #-- len (optional) - a postive number representing the length of the string 
  def self.random_string(len = 10)
        o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
        string = (0...len).map { o[rand(o.length)] }.join
  end

  def random_string(len = 10)
        o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
        string = (0...len).map { o[rand(o.length)] }.join
  end

  def self.random_string_lower(len = 5)
        o = [('a'..'z')].map { |i| i.to_a }.flatten
        string = (0...len).map { o[rand(o.length)] }.join
  end
  #----------------------------------------

  #--- json to hash------------------------
  #-- Takes a json string and returns a symbolic hash
  #-- json - a json formatted string
  def json_to_hash(json)
   JSON.parse(json,:symbolize_names => true)
  end
  #----------------------------------------

  #-----------------------------------------------
  #-- Opens a json file and greats a symbolic hash
  #-- path - This is the path to the json file. 
  #-----------------------------------------------
  def self.open_json_as_hash(path)
      @json = File.read(path)
      JSON.parse(@json,:symbolize_names => true)
  end

  def self.open_csv_as_hash(path)
    body = File.read(path)
    csv = CSV.new(body,:headers => true, :header_converters => :symbol, :converters => :all)
    hash = csv.to_a.map {|row| row.to_hash }
  end

  def self.deep_copy(hash)
    Marshal.load(Marshal.dump(hash))
  end

#=====================================

#=== Network Helper Methods ============
  #--hash to query string----------------------------------------
	# Turns a hash to a url query string to be used with @http
	# Takes: hash of values
  # Encodes the values for the url string
	# Returns: a url query string of the values
	# e.g. {one:"one",two:"two"}  => one=one&two=two
	def hash_to_querystring(params) #Hash to Query String
  	  res = ""
      params = escape_hash(params) 
   		params.each { |key,val|
     		if val.kind_of?(Array)
       			if "#{key}" == "elements" || "#{key}" == "emails" #forms use a different format
              res << "#{key}=#{JSON.generate(val)}&" 
            else
              val.each {|v|
                v = CGI::escape v
         			  res << "#{key}=#{v}&"
       			  }      
            end
     		else
        		res << "#{key}=#{val}&"
       	end        
    	}
    	res
		end
  #---------------------------------------------------------------
  
  #--- escape hash values-----------------------------------------
  #-- Takes a hash and converts the values to the URL encoded forms
  #-- hash - a non-embeded hash 
  def escape_hash(hash) 
    encoded_hash = {}
    hash.each do |key,value|
        if value.class == String #non string values can be passed into the parameters. The encoding only needs to be performed on Sting objects. 
          value = CGI::escape value
        end
        encoded_hash[:"#{key}"] = value
     end
    encoded_hash
  end
  #----------------------------------------------------------------

#=================================================


#=== API helpers =================================
  
  #--------------------------------------------------------
  #-- This is method to be used for testing
  #-- The takes the target api (api), and merges it with the test data (data)
  #-- api - a single enitiy from one of the api sets
  #-- data - test data. :params is required for the data set. Use {} to test the default case. It will merge any other added params.
  #---------------------------------------------------------
  def self.merge_test_with_template(api,data)
      tests = {}
      data.each do |key,value|
        tests[key] = api.clone
        value.each do |key2,value2|
          if key2 == :params
             tests[key][:params] = tests[key][:params].merge(value[:params])
          else
            tests[key][key2] = value2
          end
      end
      end
      tests
  end

  def append_ftp_value(address,ftp_type)
    if ftp_type == "2" || ftp_type == 2
      return "p:#{address}"
    elsif ftp_type == "0" || ftp_type == 0
      return "s:#{address}"
    else
      return address
    end
  end
#============================================================

#prep test
  def self.prep_test(parent,child,type="user")
    api_parent = send(parent)
    api = api_parent[:"#{child}"]#get the default data for the test
    data = open_json_as_hash("#{OUApi.gem_root}/spec/test_data/#{type}/#{parent}/#{child}.json")#get the test data
    tests = merge_test_with_template(api,data)#prep the data.
  end


end#OUAPI