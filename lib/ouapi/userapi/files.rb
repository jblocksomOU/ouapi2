module OUApi	
 class User
 	def files
			{
			list:{ path:'/files/list',params:{site:@site,path:"/"},response:{}},
			copy:{path:'/files/copy',params:{site:@site,destination:'/',remote:'false',path:'/_leftnav.inc'},response:{}},
			checkin:{path:'files/checkin', params:{},response:{}},
			rename:{path:'files/rename', params:{},response:{}},
			settings:{path:'files/settings', params:{},response:{}},
			info:{path:'files/info', params:{},response:{}},
			new_folder:{path:'files/new_folder', params:{},response:{}},
			publish:{path:'files/publish', params:{},response:{}},
			multipublish:{path:'files/multipublish', params:{},response:{}}
			}
	end
 end
end

#/files/upload This has to be special