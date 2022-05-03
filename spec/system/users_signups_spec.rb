require 'rails_helper'

RSpec.describe "UsersSignups", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "POST/signup #create" do
    context "無効な値の場合" do
      it "ユーザー登録はされない" do
        expect {
          post users_path, params: { user: { name: '',
                                              email: 'user@invlid',
                                              password: 'foo',
                                              password_confirmation: 'bar'}}
          }.to_not change(User, :count)
      end

      it "エラーメッセージ用の表示領域が描画されていること" do
        visit signup_path
        fill_in "Name",	with: ''
        fill_in 'Email', with: 'user@invlid'
        fill_in 'Password', with: 'foo'
        fill_in 'Confirmation', with: 'bar'
        click_button 'Create my account'

        expect(page).to have_selector 'div#error_explanation'
        expect(page).to have_selector 'div.field_with_errors'
      end
    end

    context "有効な値の場合" do
      let(:user) { FactoryBot.build(:user) }

      before do
        visit signup_path
        fill_in "Name",	with: user.name
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Confirmation', with: user.password_confirmation
      end

      it "ユーザー登録がされる" do
        expect {
          find('input[name="commit"]').click
          }.to change {User.count}.by(1)
        end

        it "登録完了のflashが表示される" do
          expect(flash).to be_any
        end
    end
  end
end
