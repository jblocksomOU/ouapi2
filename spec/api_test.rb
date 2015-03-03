module Smoke_test
shared_examples_for "API_test" do |title,api| 
	describe "Api tests for /#{title}" do
				before :all do
					if api[:type] == "post"
			   			@response = @user.post(api)
			   			puts "post"
			   		else
			   			@response = @user.get(api)
			   			puts "get"
			   		end
				end

				it "Is the proper status code returned" do
					if api[:result] == "fail"
			        	expect(@response.code).to eq('400')
			        else
			        	expect(@response.code).to eq('200')
			        end
			   	end
	end
end #Shared smoke test
end #Ouauto