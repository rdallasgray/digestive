# encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../lib/digestive/user'

describe Digestive::User do

  before do
    @user_attrs = { name: 'Rich', username: 'tea', password: 'hobnob' }
    @user = Digestive::User.new(@user_attrs)
  end

  it 'should conceal the password in json' do
    json = @user.to_json
    json.wont_match @user_attrs[:password]
  end

  it 'should digest-encrypt the password on save' do
    a1 = [@user.username, Digestive::User::DIGEST_REALM, @user.password].join(':')
    encrypted_password = Digest::MD5.hexdigest(a1).to_s
    @user.save
    @user.password.must_equal encrypted_password
  end
end
