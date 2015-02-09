module OUApi	
class Superadmin
 	
	#---Create Account,Site,and User---
	def default_account(args)
		account = args[:account]
		site = args[:site]
		user = args[:user]

		create_account(account)

		site[:account] = account[:name]
		response = create_site(site)

		user[:account] = account[:name]
		create_user(user)
	end
	#----------------------------------

end
end