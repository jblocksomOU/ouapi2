describe OUApi do

  describe "Smoke Test" do
  load "#{OUApi.spec_root}/smoke_test.rb"  

  type = "files"
  apis = ["list","settings"]

  apis.each do |api|
    tests = OUApi.prep_test(type,api)
    tests.each do |key,test|
  	 it_should_behave_like "API_test","#{test[:title]}:#{type}/#{api}",test
    end
  end

  end
end