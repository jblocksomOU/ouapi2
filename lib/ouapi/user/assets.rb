module OUApi	
 class User
 	def assets
			{
			new:{path:'/assets/new', params:{},response:{}},
			save:{path:'/assets/save', params:{},response:{}}
			}
	end
 end
end

#gallery and form assets will need special treatment