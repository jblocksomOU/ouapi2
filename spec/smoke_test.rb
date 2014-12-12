module Smoke_test
shared_examples_for "API_test" do |title,api| 
	describe "#{title}" do
				before :all do
					if api[:type] == "post"
			   			@response = @user.post(api)
			   		else
			   			@response = @user.get(api)
			   		end
				end

#test for userlevel restriction
				if (api[:restrictions] || -1) > RSpec.configuration.userlevel #-1 is to handel the case when authorization is universal.
					it "Is the proper status code returned for the unauthorized request: 403" do
			        	expect(@response.code).to eq('403')
			   		end

			   		it "Is the expected response returned" do
				   		body = @user.json_to_hash(@response.body)
				   		expected = OUApi.error[:unauthorized]
				   		expect(body).to eq(expected[:response])
			   		end
#test for permission restrictions
			   	elsif (api[:permission] || -1) > RSpec.configuration.userlevel #-1 is to handel the case when permissions are not considred or a permission value is not provided.
			   		it "Is the proper status code returned for permission denied: 400" do
			        	expect(@response.code).to eq('400')
			   		end

			   		it "Is the expected response returned" do
				   		body = @user.json_to_hash(@response.body)
				   		expected = OUApi.error[:access_denied]
				   		expect(body).to eq(expected[:response])
			   		end
#test for expected failure
			   	elsif api[:result] == "fail"
					it "Is the proper status code returned for the bad request: 400" do
			        	expect(@response.code).to eq('400')
			   		end

			   		it "Is the expected response returned" do
				   		body = @user.json_to_hash(@response.body)
				   		keys = body.keys
				   		expected = api[:response]
				   		expected.map! { |x| x.to_sym }
				   		expect(keys).to eq(expected)
			   		end
#test for expected success
			   	else
					it "Is the proper status code returned for the successful request: 200" do
			        	expect(@response.code).to eq('200')
			   		end

			   		it "Is the expected response returned" do
				   		body = @user.json_to_hash(@response.body)
				   		keys = body.keys
				   		expected = api[:response]
				   		expected.map! { |x| x.to_sym }
				   		expect(keys).to eq(expected)
			   		end
				end
	end
end #Shared smoke test
end #Ouauto