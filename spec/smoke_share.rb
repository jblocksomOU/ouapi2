module Smoke_test
shared_examples_for "Smoke_Test" do |title,apis| 

	describe "Api tests for /#{title}" do
		apis.each do |key,value|

			describe "/#{title}/#{key} api test" do
				before :all do
					value[:params] = @user.prep_params(value)
					if value[:type] == "post"
			   			@response = @user.post(value)
			   			puts "post"
			   		else
			   			@response = @user.get(value)
			   			puts "get"
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