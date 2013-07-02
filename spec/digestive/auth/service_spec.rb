# encoding: UTF-8

require_relative '../../spec_helper'
require_relative '../../../lib/digestive/auth/service'

describe Digestive::Auth::Service do

  class Provider
    def self.request_http_digest_authentication(realm, message=nil)
    end
    def self.authenticate_with_http_digest(realm, &procedure)
      procedure.call('test')
    end
  end

  before do
    @service = Digestive::Auth::Service.new(User, Provider)
  end

  it 'should prompt for authentication if a user is not authenticated' do
    Provider.expects(:request_http_digest_authentication)
      .with(User::DIGEST_REALM)
    @service.stubs(:authenticated?).returns(false)
    @service.authenticate
  end

  it 'should authenticate a user with http digest' do
    Provider.expects(:authenticate_with_http_digest).with(User::DIGEST_REALM)
    @service.authenticate
  end

  it 'should return the user if authenticated' do
    @service.authenticate
    @service.user.must_be_instance_of User
  end

  it 'should use a strategy to authorize a user' do
    @service.authenticate { |u| false }
    @service.user.must_equal nil
    @service.authenticate { |u| true }
    @service.user.must_be_instance_of User
  end
end
