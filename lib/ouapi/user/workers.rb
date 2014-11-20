module OUApi	
class User
 	
 	def workers
 		OUApi.workers
	end

	def workers_status(params)
		status = workers[:status]
		read(status,params)
	end 

end
end