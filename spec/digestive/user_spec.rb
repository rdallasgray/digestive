# encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../lib/digestive/user'

describe Digestive::User do
  class Role < ActiveRecord::Base
    class << self
      attr_writer :attrs
    end
    def self.find(id)
      new(@attrs)
    end
    def self.find_by_name(name)
      new(@attrs)
    end
  end

  class AdminSession < ActiveRecord::Base
    class << self
      attr_writer :current_session
    end
    scope :current, -> { @current_session }
  end

  before do
    @user_attrs = { name: 'Rich', username: 'tea', password: 'hobnob', role_id: 1 }
    @role_attrs = { name: 'staff', privilege_level: 2 }
    @admin_session_attrs = {}
    Role.attrs = @role_attrs
    @role = Role.new(@role_attrs)
    @role.id = 1
    @admin_session = AdminSession.new(@admin_session_attrs)
    @user = Digestive::User.new(@user_attrs)
    @user.role = @role
    @user.admin_sessions = [@admin_session]
  end

  it 'should return the name of its role' do
    @user.role_name.must_equal @role_attrs[:name]
  end

  it 'should assess its privilege_level' do
    @user.has_privilege_level?(:staff).must_equal true
    Role.attrs = { name: 'admin', privilege_level: 1 }
    @user.has_privilege_level?(:admin).must_equal false
  end

  it 'should get its most recent admin session' do
    @user.most_recent_admin_session.must_equal @admin_session
  end

  it 'should get a current admin session' do
    AdminSession.current_session = @admin_session
    @user.current_admin_session.must_equal @admin_session
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
