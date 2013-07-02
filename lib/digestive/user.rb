# encoding: UTF-8

require_relative 'credentials'

module Digestive
  # A simple User class which will function with Digestive.
  # Can be used as an example or extended.
  class User < ::ActiveRecord::Base
    include Credentials

    # The realm to which the user will authenticate
    DIGEST_REALM = 'user@example.com'

    validates  :username, presence: true, uniqueness: true
    validates  :password, presence: true

    attr_accessible :username, :password

    before_save :digest_encrypt_password

    # The JSON representation of a User conceals the password.
    def as_json(options={})
      hash = super(options)
      hash['user']['password'] = ''
      hash
    end

    private

    # User's password is encrypted prior to saving.
    def digest_encrypt_password
      if password_changed? || username_changed?
        self.password = encrypt_password(username, DIGEST_REALM, password)
      end
    end
  end
end
