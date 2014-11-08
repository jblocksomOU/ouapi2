module OUApi

	@files_json = File.read("#{gem_root}/lib/ouapi/json/files.json")
	@files = JSON.parse(@files_json,:symbolize_names => true)
	
	def self.files
		@files
	end

	def self.json_assets
		contents = File.read("#{gem_root}/lib/ouapi/json/assets.json")
		contents
	end

	def self.assets
		JSON.parse(json_assets,:symbolize_names => true)
	end

	def self.randomize(apis)
		apis.each do |api_key,api_param|
			api_param[:params].each { |key, value| 
				if value == "random"
					apis[api_key][:params][key] = "thisisrandom"
				elsif value == "target_site"
					puts "hey"
					apis[api_key][:params][key] = @site
				elsif value == "target_account"
					apis[api_key][:params][key] = @account
				elsif value == "file"
					apis[api_key][:params][key] = "#{gem_root}/dev/sample"
				end
				puts apis[api_key][:params]
			}
		end
	end

end