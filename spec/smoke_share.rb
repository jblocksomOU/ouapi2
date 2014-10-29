module Smoke_test
shared_examples_for "Smoke_test" do |title,apis| 

	describe "Api tests for /#{title}" do
		apis.each do |key,value|

			describe "/#{title}/#{key} api test" do
				before :all do
					if value["type"] == "post"
			   			@response = @user.post(value)
			   		else
			   			@response = @user.get(value)
			   		end
				end

				it "Is the proper status code returned" do
			        expect(@response.code).to eq('200')
			   	end
	   		end
		end
	end
end #Shared smoke test
end #Ouauto