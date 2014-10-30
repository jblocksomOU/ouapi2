module OUApi
	

	def self.json_files
		contents = File.read("#{gem_root}/lib/ouapi/json/files.json")
		contents
	end

	def self.files
		JSON.parse(json_files,:symbolize_names => true)
	end


	def self.json_assets
		contents = File.read("#{gem_root}/lib/ouapi/json/assets.json")
		contents
	end

	def self.assets
		JSON.parse(json_assets,:symbolize_names => true)
	end

end