# encoding: UTF-8

require 'digest/md5'

module Digestive
  module Credentials
    def encrypt_password(username, realm, password)
      a1 = [username, realm, password].join(':')
      ::Digest::MD5.hexdigest(a1).to_s
    end
  end
end
