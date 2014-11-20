module OUApi

  #===== Api Set Varaibles ====================================
  #- Proccess at start up. Opens and stores the api json files varaibles to prevent a cycle of opening and closing the file. This should be done for each api set. See /lib/ouapi/json for api json files
  @files = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/files.json")
  @assets = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/assets.json")
  @zipimport = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/zipimport.json")
  @workers = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/workers.json")
  #===========================================================

  #===== Api access methods ==================================
  #These methods are for allowing access to the api data.
  def self.files
    @files
  end

  def self.assets
    @assets
  end

  def self.zipimport
    @zipimport
  end

  def self.workers
    @workers
  end
  #===========================================================


	
end