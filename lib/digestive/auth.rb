# encoding: UTF-8

require_relative 'auth/service'

module Digestive
  module Auth
    # Convenience method to require authentication.
    # If successful, will set the @current_user
    # instance variable of the including object to the
    # authenticated user.
    # @param [Hash] options
    # @option options [Object] credentialed
    #   An object responding to constant DIGEST_REALM and
    #   method find_by_username.
    #   See {Digestive::User}, to which the option defaults.
    # @option options [Object] provider
    #   An object responding to methods
    #   `authenticate_with_http_digest` and
    #   `request_http_digest_authentication`.
    #   Defaults to nil; if not given, {Digestive::Auth::Service}
    #   will expect the methods to be mixed-in, which
    #   in the context of Rails, they should be.
    # @param [Block] strategy
    #   A block, accepting a single argument, intended
    #   to be the authenticating user, which will
    #   return true or false to indicate authorization.
    # @return [Object]
    #   The authenticated user, or nil if authentication fails.
    def authenticate(options={}, &strategy)
      credentialed = options[:credentialed] || User
      provider = options[:provider]
      service = Service.new(credentialed, provider)
      service.authenticate(&strategy)
      @current_user = service.user
    end
  end
end
