module OUApi

  #===== Api Set Varaibles ====================================
  #- Proccess at start up. Opens and stores the api json files varaibles to prevent a cycle of opening and closing the file. 
  #- This should be done for each api set. See /lib/ouapi/json for api json files
  json_dir = "#{gem_root}/lib/ouapi/api_json/user"

  @account = open_json_as_hash("#{json_dir}/account.json")
  @addons = open_json_as_hash("#{json_dir}/addons.json")
  @assets = open_json_as_hash("#{json_dir}/assets.json")
  @auxsites = open_json_as_hash("#{json_dir}/auxsites.json")
  @directories = open_json_as_hash("#{json_dir}/directories.json")
  @feeditems = open_json_as_hash("#{json_dir}/feeditems.json")
  @feeds = open_json_as_hash("#{json_dir}/feeds.json")
  @files = open_json_as_hash("#{json_dir}/files.json")
  @fontsizesets = open_json_as_hash("#{json_dir}/fontsizesets.json")
  @gadgets = open_json_as_hash("#{json_dir}/gadgets.json")
  @groups = open_json_as_hash("#{json_dir}/groups.json")
  @sites = open_json_as_hash("#{json_dir}/sites.json")
  @snippets = open_json_as_hash("#{json_dir}/snippets.json")
  @templates = open_json_as_hash("#{json_dir}/templates.json")
  @templategroups = open_json_as_hash("#{json_dir}/templategroups.json")
  @toolbars = open_json_as_hash("#{json_dir}/toolbars.json")
  @users = open_json_as_hash("#{json_dir}/users.json")
  @workers = open_json_as_hash("#{json_dir}/workers.json")
  @zipimport = open_json_as_hash("#{json_dir}/zipimport.json")

  @servlet = open_json_as_hash("#{json_dir}/servlet.json") 
  @error = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/error.json")
  #===========================================================

  #===== Api access methods ==================================
  #These methods are for allowing access to the api data.
  def self.account
    deep_copy(@account)
  end

  def self.addons
    deep_copy(@addons)
  end

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

  def self.gadgets
    deep_copy(@gadgets)
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
	
end