require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'Example User', email: 'user@example.com') }

  it 'userが有効であること' do
    expect(user).to be_valid
  end

  it '名前が存在しないといけない' do
    user.name = '     '
    expect(user).to_not be_valid
  end

  it 'メールアドレスが存在しないといけない' do
    user.email = '     '
    expect(user).to_not be_valid
  end

  it '名前は50文字以上では入力できない' do
    user.name = 'a' * 51
    expect(user).to_not be_valid
  end

  it 'アドレスは255文字以上では入力できない' do
    user.name = "#{'a' * 244}@example.com"
    expect(user).to_not be_valid
  end
end
