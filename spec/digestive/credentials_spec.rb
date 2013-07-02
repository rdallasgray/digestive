# encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../lib/digestive/credentials'

describe Digestive do

  class Encryptable
    include Digestive::Credentials
  end

  before do
    @encryptable = Encryptable.new
  end

  it 'should encrypt a password for a set of credentials' do
    username = 'test_username'
    realm = 'test_realm'
    password = 'test_password'
    encrypted_password = @encryptable.encrypt_password(username, realm, password)
    a1 = [username, realm, password].join(':')
    sample_password = Digest::MD5.hexdigest(a1).to_s
    encrypted_password.must_equal sample_password
  end
end
