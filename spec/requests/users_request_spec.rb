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

  describe "POST/signup" do
    it "無効な値の場合、ユーザー登録はされない" do
      expect {
        post users_path, params: { user: { name: '',
                                            email: 'user@invlid',
                                            password: 'foo',
                                            password_confirmation: 'bar'}}
        }.to_not change(User, :count)
    end

    context "有効な値の場合" do
      let(:user_params) { { user: { name: 'Example User',
                            email: 'user@example.com',
                            password: 'password',
                            password_confirmation: 'password' } } }

      it "ユーザー登録がされる" do
        expect {
          post users_path, params: user_params
        }.to change(User, :count).by 1
      end

      it "flashが表示される" do
        post users_path, params: user_params
        expect(flash).to be_any
      end
    end
  end

end
