# encoding: UTF-8

module Digestive
  class User < ::ActiveRecord::Base
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
        a1 = [username, DIGEST_REALM, password].join(':')
        self.password = Digest::MD5.hexdigest(a1).to_s
      end
    end
  end
end
