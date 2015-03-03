module OUApi	
class Superadmin
 	
	#---Create Account,Site,and User---
	def default_account(args)
		accounts = args[:account]
		site = args[:site]
		user = args[:user]

		create_account(account)

		site[:account] = accounts[:name]
		response = create_site(site)

		user[:account] = accounts[:name]
		create_user(user)
	end
	#----------------------------------

end
end