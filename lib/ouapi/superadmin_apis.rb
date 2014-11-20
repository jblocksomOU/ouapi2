module OUApi
	#===== Api Set Varaibles ====================================
  #- Proccess at start up. Opens and stores the api json files varaibles to prevent a cycle of opening and closing the file. This should be done for each api set. See /lib/ouapi/json for api json files
  @superadmin_account = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/superadmin/account.json")
  @superadmin_site = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/superadmin/site.json")
  @superadmin_user = open_json_as_hash("#{gem_root}/lib/ouapi/api_json/superadmin/user.json")
  #===========================================================

  #===== Api access methods ==================================
  #These methods are for allowing access to the api data.
  def self.superadmin_account
    @superadmin_account
  end

  def self.superadmin_site
    @superadmin_site
  end

  def self.superadmin_user
    @superadmin_user
  end
  #===========================================================
end