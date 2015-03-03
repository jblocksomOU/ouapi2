module OUApi
	#===== Api Set Varaibles ====================================
  #- Proccess at start up. Opens and stores the api json files varaibles to prevent a cycle of opening and closing the file. This should be done for each api set. See /lib/ouapi/json for api json files
  superadmin_json_dir = "#{gem_root}/lib/ouapi/api_json/superadmin"

  @superadmin_accounts = open_json_as_hash("#{superadmin_json_dir}/accounts.json")
  @superadmin_site = open_json_as_hash("#{superadmin_json_dir}/site.json")
  @superadmin_user = open_json_as_hash("#{superadmin_json_dir}/user.json")
  #===========================================================

  #===== Api access methods ==================================
  #These methods are for allowing access to the api data.
  def self.superadmin_accounts
    deep_copy(@superadmin_accounts)
  end

  def self.superadmin_site
    deep_copy(@superadmin_site)
  end

  def self.superadmin_user
    deep_copy(@superadmin_user)
  end
  #===========================================================
end