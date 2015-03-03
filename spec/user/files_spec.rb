describe OUApi do

  describe "Smoke Test" do
  load "#{OUApi.spec_root}/smoke_test.rb"  

  type = "files"
  apis = ["info","list","settings"]
  test_data = RSpec.configuration.test_data

  apis.each do |api|
    tests = OUApi.prep_test(type,api,test_data)
  	 it_should_behave_like "API tests",tests
  end

  end
end