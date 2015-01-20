module OUApi	
class User
 	
 	def workers
 		OUApi.workers
	end

	def workers_status(params)
		status = workers[:status]
		status[:params].merge!(params)
		get(status)
	end 

end
end