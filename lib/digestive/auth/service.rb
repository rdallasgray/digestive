# encoding: UTF-8

module Digestive
  module Auth
    # Handles authentication of a credentialed object, using a given provider.
    # The credentialed object will normally be a user, and the provider
    # `ActionController::HttpAuthentication::Digest::ControllerMethods`.
    class Service
      # Create a new Digest::Auth::Service.
      # @param [Object] credentialed
      #   An object responding to constant DIGEST_REALM and
      #   method find_by_username. See {Digestive::User}.
      # @param [Object] provider
      #   An object responding to methods
      #   `authenticate_with_http_digest` and
      #   `request_http_digest_authentication`.
      #   Defaults to nil; if not given, {Digestive::Auth::Service}
      #   will expect the methods to be mixed-in, which
      #   in the context of Rails, they should be.
      def initialize(credentialed, provider=nil)
        @credentialed = credentialed
        @provider = provider || self
      end

      # Authenticate, optionally with an authorization strategy.
      # If authentication can't be verified, prompt for credentials.
      # @param [Block] strategy
      #   Block accepting one argument (an object returned by
      #   @credentialed.find_by_username) and returning a boolean.
      def authenticate(&strategy)
        unless authenticated?(strategy)
          realm = @credentialed::DIGEST_REALM
          @provider.request_http_digest_authentication(realm)
        end
      end

      # Determine whether a user is currently authenticated.
      # @param [Proc] strategy
      #   Optional; an authorization strategy. See {#authenticate}
      # @return [Object]
      #   The authenticated user or nil
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
