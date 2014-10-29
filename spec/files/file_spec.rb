describe OUApi do
  describe "Smoke Test" do
  load "#{OUApi.spec_root}/smoke_share.rb"  

   apis = OUApi.files

   	it_should_behave_like "Smoke_test","file",apis

  end
end