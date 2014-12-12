module OUApi

  #===== Api Set Varaibles ====================================
  #- Proccess at start up. Opens and stores the api json files varaibles to prevent a cycle of opening and closing the file. 
  #- This should be done for each api set. See /lib/ouapi/json for api json files
  @assets = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/assets.json")
  @auxsites = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/auxsites.json")
  @directories = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/directories.json")
  @feeds = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/feeds.json")
  @files = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/files.json")
  @groups = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/groups.json") 
  @sites = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/sites.json")
  @snippets = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/snippets.json")
  @templates = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/templates.json")
  @templategroups = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/templategroups.json")
  @workers = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/workers.json")
  @zipimport = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/zipimport.json")

  @error = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/error.json")
  #===========================================================

  #===== Api access methods ==================================
  #These methods are for allowing access to the api data.
  def self.assets
    @assets
  end

  def self.auxsites
    @auxsites
  end

  def self.directories
    @directories
  end

  def self.files
    @files
  end

  def self.feeds
    @feeds
  end

  def self.groups
    @groups
  end

  def self.sites
    @sites
  end

  def self.snippets
    @snippets
  end

  def self.templategroups
    @templategroups
  end

  def self.templates
    @templates
  end

  def self.workers
    @workers
  end

  def self.zipimport
    @zipimport
  end
  
  def self.error
    @error
  end
  #===========================================================


	
end