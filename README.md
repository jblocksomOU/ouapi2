ouapi
=====
for the purposes of internal testing and automation of tasks 
#### 1. Fork, then clone this repo.
#### 2. cd into the cloned folder and save lib/config_example.rb as config.rb, update the values with your default host, skin, account, site, user, etc
#### 3. from command line in project root: run 'bundle install' - make sure you are using ruby 1.9.3 or later, preferrably ruby 2.0.0 for Windows users get PIK http://rubyinstaller.org/add-ons/pik/ , MAC or Linux users get RVM https://rvm.io/
#### 4. run 'gem build ouapi.gempsec', then 'gem install ouapi'
#### 5. in a .rb file add - require 'ouapi' to the top of a file
## 6. create a new OUApi::User

  api_user = OUApi::User.new({
                 host: OUApi.default[:host],
                 skin: OUApi.default[:skin],
                 account: OUApi.default[:account],
                 username: OUApi.default[:username],
                 password: OUApi.default[:password]
   })
   
   same as: api_user = OUApi::User.new
   
   the hash arguments let you log in as any user you have credentials for. The default args in the config.rb are for convienence.

##make an API call
  
###signature

  api_user.call(method, path, param_hash)

###example
  params = { site: "Clean_Demo_HTML5", path: "/academics" }

  api_user.call("get", "/files/list", params)

  return value will be json string

ouapi

### Response class
  there is a custom response class to help facilitate handling the json from the Api
  the User class has a shortcut method to create this object when making a method call ( method call should map to Api call)
  
   res = @user.res(:files_list, params)
   
   puts res.body
   
   puts res.code
   
the @user.res method takes two arguments. One is a symbol :files_list that maps to a User method name. The second argument is a hash of the params to be sent with the Api call. 

## GET, POST, get stuff done quicker for OU Support and Implementations

disclaimer: I am not sure how long this method of authenticating will work. Dev may change stuff as this is not an official OmniUpdate API SDK. 
  
  
  
  
  
