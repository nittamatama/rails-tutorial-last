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

        it "ログイン状態になる" do
        post users_path, params: user_params
        expect(logged_in?).to be_truthy
      end
    end
  end

  describe "PATCH/users" do
    let!(:user) { FactoryBot.create(:user)}

    it 'タイトルがEdit user | Ruby on Rails Tutorial Sample Appであること' do
      get edit_user_path(user)
      expect(response.body).to include full_title('Edit user')
    end

    context "無効な値の場合" do

      it "更新が失敗する" do
        patch user_path(user), params: { user: { name: '',
                                                  email: 'foo@invlid',
                                                  password: 'foo',
                                                  password_confirmation: 'bar' } }
        user.reload
        expect(user.name).to_not eq ''
        expect(user.email).to_not eq ''
        expect(user.password).to_not eq 'foo'
        expect(user.password_confirmation).to_not eq 'bar'
      end

      it "更新が失敗した後、編集ページに戻る" do
        get edit_user_path(user)
        patch user_path(user), params: { user: { name: '',
                                                email: 'foo@invlid',
                                                password: 'foo',
                                                password_confirmation: 'bar' } }
        expect(response.body).to include full_title('Edit user')
      end
    end
  end

end
