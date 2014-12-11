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

				it "Is the proper status code returned" do
					if api[:result] == "fail"
			        	expect(@response.code).to eq('400')
			        else
			        	expect(@response.code).to eq('200')
			        end
			   	end

			   	it "Are the expected keys returned" do
			   		body = @user.json_to_hash(@response.body)
			   		keys = body.keys
			   		expected = api[:response]
			   		expected.map! { |x| x.to_sym }
			   		expect(keys).to eq(expected)
			   	end
	end
end #Shared smoke test
end #Ouauto