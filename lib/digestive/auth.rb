# encoding: UTF-8

require_relative 'auth/service'

module Digestive
  module Auth
    def authenticate(options={}, &strategy)
      credentialed = options[:credentialed] || User
      provider = options[:provider]
      service = Service.new(credentialed, provider)
      service.authenticate(&strategy)
    end
  end
end
