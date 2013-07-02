# encoding: UTF-8

module Digestive
  module Auth
    class Service
      def initialize(credentialed, provider=nil)
        @credentialed = credentialed
        @provider = provider || self
      end

      def authenticate(&strategy)
        unless authenticated?(strategy)
          realm = @credentialed::DIGEST_REALM
          @provider.request_http_digest_authentication(realm)
        end
      end

      def authenticated?(strategy=nil)
        realm = @credentialed::DIGEST_REALM
        strategy ||= ->(user) { true }
        user = nil
        @provider.authenticate_with_http_digest(realm) do |username|
          user = @credentialed.find_by_username(username)
          user.nil? ? nil : user.password
        end
        user if strategy.call(user)
      end
    end
  end
end
