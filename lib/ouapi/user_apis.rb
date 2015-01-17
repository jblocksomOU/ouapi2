module OUApi

  #===== Api Set Varaibles ====================================
  #- Proccess at start up. Opens and stores the api json files varaibles to prevent a cycle of opening and closing the file. 
  #- This should be done for each api set. See /lib/ouapi/json for api json files
  @assets = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/assets.json")
  @auxsites = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/auxsites.json")
  @directories = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/directories.json")
  @feeditems = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/feeditems.json")
  @feeds = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/feeds.json")
  @files = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/files.json")
  @fontsizesets = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/fontsizesets.json")
  @groups = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/groups.json")
  @sites = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/sites.json")
  @snippets = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/snippets.json")
  @templates = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/templates.json")
  @templategroups = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/templategroups.json")
  @toolbars = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/toolbars.json")
  @users = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/users.json")
  @workers = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/workers.json")
  @zipimport = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/zipimport.json")

  @error = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/error.json")
  @servlet = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/user/servlet.json") 
  #===========================================================

  #===== Api access methods ==================================
  #These methods are for allowing access to the api data.
  def self.assets
    deep_copy(@assets)
  end

  def self.auxsites
    deep_copy(@auxsites)
  end

  def self.directories
   deep_copy(@directories)
  end

  def self.files
    deep_copy(@files)
  end

  def self.feeds
    deep_copy(@feeds)
  end

  def self.feeditems
    deep_copy(@feeditems)
  end

  def self.fontsizesets
    deep_copy(@fontsizesets)
  end

  def self.groups
    deep_copy(@groups)
  end

  def self.servlet
    deep_copy(@servlet)
  end

  def self.sites
    deep_copy(@sites)
  end

  def self.snippets
    deep_copy(@snippets)
  end

  def self.templategroups
    deep_copy(@templategroups)
  end

  def self.templates
    deep_copy(@templates)
  end

  def self.toolbars
    deep_copy(@toolbars)
  end

  def self.users
    deep_copy(@users)
  end

  def self.workers
    deep_copy(@workers)
  end

  def self.zipimport
    deep_copy(@zipimport)
  end
  
  def self.error
    deep_copy(@error)
  end
  #===========================================================

 def deep_copy(hash)
    Marshal.load(Marshal.dump(hash))
  end
	
end