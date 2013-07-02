# encoding: UTF-8

require_relative 'credentials'

module Digestive
  class User < ::ActiveRecord::Base
    include Credentials

    DIGEST_REALM = 'user@example.com'

    validates  :username, presence: true, uniqueness: true
    validates  :password, presence: true

    attr_accessible :username, :password

    before_save :digest_encrypt_password

    def as_json(options={})
      hash = super(options)
      hash['user']['password'] = ''
      hash
    end

    private

    def digest_encrypt_password
      if password_changed? || username_changed?
        self.password = encrypt_password(username, DIGEST_REALM, password)
      end
    end
  end
end
