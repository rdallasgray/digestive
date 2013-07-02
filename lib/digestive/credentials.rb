# encoding: UTF-8

require 'digest/md5'

module Digestive
  module Credentials
    # Encrypt a given password for comparison with a password
    # given during the authentication process, per
    # {http://tools.ietf.org/html/rfc2069 RFC2069}.
    # @param [String] username
    #   User's username
    # @param [String] realm
    #   Realm to which the user is authenticating
    # @param [String] password
    #   User's password
    # @return [String]
    #   A string encrypted per RFC2069
    def encrypt_password(username, realm, password)
      a1 = [username, realm, password].join(':')
      ::Digest::MD5.hexdigest(a1).to_s
    end
  end
end
