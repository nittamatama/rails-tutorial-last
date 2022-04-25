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
end
