module OUApi	
class Superadmin
 	
	#---Create Account,Site,and User---
	def default_account(args)
		account = args[:account]
		site = args[:site]
		user = args[:user]

		response = create_account(account)
		body = json_to_hash(response.body)
		account_name = body[:account]

		site[:account] = account_name
		create_site(site)

		user[:account] = account_name
		create_user(user)
	end
	#----------------------------------

end
end