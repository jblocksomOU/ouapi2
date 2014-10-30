escribe OUApi do
  describe "Test" do

    it "Test" do
     	api = @user.files[:list]
		api[:params] = {path:'/about'}

		response = @user.get_w_cookie(api)
		puts response.body
    end

  end
end
