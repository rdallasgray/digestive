# encoding: UTF-8

module Digestive
    class User < ::ActiveRecord::Base
      DIGEST_REALM = 'user@example.com'

      belongs_to :role
      has_many   :admin_sessions

      validates  :username, presence: true, uniqueness: true
      validates  :name, presence: true
      validates  :password, presence: true
      validates  :role_id, presence: true
      validate   :role_exists

      default_scope order: 'username'

      attr_accessible :username, :password, :role_id, :name

      before_save { |user| digest_encrypt_password(user) }

      def role_name
        role.name
      end

      def has_privilege_level?(role_name)
        given_role = Role.find_by_name(role_name.to_s)
        role.privilege_level <= given_role.privilege_level
      end

      def most_recent_admin_session
        admin_sessions.first
      end

      def current_admin_session
        admin_sessions.current.first
      end

      def as_json(options={})
        hash = super(options)
        hash['user']['password'] = ''
        hash
      end

      private

      def digest_encrypt_password(user)
        if password_changed? || username_changed?
          username = user.username || self.username
          a1 = [username, self.class::DIGEST_REALM, user.password].join(':')
          self.password = Digest::MD5.hexdigest(a1).to_s
        end
      end

      def role_exists
        Role.find(self.role_id)
      rescue
        errors.add(:role_id, 'was not found')
      end
    end
end
