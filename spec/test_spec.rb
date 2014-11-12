describe OUApi do
  describe "Smoke Test" do
  load "#{OUApi.spec_root}/api_test.rb"  

  #prep test
  api = OUApi.files[:list]#get the default data for the test
  data = OUApi.open_json_as_hash("#{OUApi.gem_root}/spec/test_data/files_list.json")#get the test data
  tests = OUApi.prep_test(api,data)#prep the data.

  tests.each do |key,test|
  	it_should_behave_like "API_test","file list",test
  end

  end
end