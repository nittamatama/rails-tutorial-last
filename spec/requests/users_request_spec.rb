require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /signup" do
    it "getメソッドで/signupにアクセスしたらステータスコード200が返ってくる" do
      get signup_path
      expect(response).to have_http_status(:success)
    end

    it "Sign up | Ruby on Rails Tutorial Sample Appが含まれること" do
      get signup_path
      expect(response.body).to include full_title('Sign up')
    end
  end

end
