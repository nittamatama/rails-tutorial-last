require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'Example User',
                        email: 'user@example.com',
                        password: 'foobar',
                        password_confirmation: 'foobar') }

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

  it 'アドレスは正常な形式の場合入力できる' do
    valide_addresses = %w[user@exmple.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valide_addresses.each do | address |
      user.email = address
      expect(user).to be_valid
    end
  end

  it 'アドレスは異常な形式の場合入力できない' do
    valide_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    valide_addresses.each do | address |
      user.email = address
      expect(user).to_not be_valid
    end
  end

  it 'メールアドレスは同じものを複数登録はできない' do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user).to_not be_valid
  end

  it 'メールアドレスは小文字で保存される' do
    mixed_case_email = "Foo@ExAMPle.CoM"
    user.email = mixed_case_email
    user.save
    expect(user.reload.email).to eq mixed_case_email.downcase
  end

  it 'passwordが必須であること' do
    user.password = user.password_confirmation = ' ' * 6
    expect(user).to_not be_valid
  end

  it 'passwordは6文字以上であること' do
    user.password = user.password_confirmation = 'a' * 5
    expect(user).to_not be_valid
  end

  describe '#authenticated?' do
    it 'digestがnilならfalseを返すこと' do
      expect(user.authenticated?('')).to be_falsy
    end
  end

end
