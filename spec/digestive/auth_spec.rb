# encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../lib/digestive/auth'
require_relative '../../lib/digestive/user'

describe Digestive::Auth do

  class Authenticatable
    include Digestive::Auth
    attr_reader :current_user
  end

  before do
    @authenticatable = Authenticatable.new
  end

  it 'should provide a convenience method' do
    service = Digestive::Auth::Service.new(::User)
    Digestive::Auth::Service.expects(:new).with(Digestive::User, nil)
      .returns(service)
    service.expects(:authenticate)
    @authenticatable.authenticate
  end

  it 'should set the authenticated user' do
    service = Digestive::Auth::Service.new(::User)
    Digestive::Auth::Service.expects(:new).returns(service)
    service.expects(:authenticate)
    service.expects(:user).returns(::User.new)
    @authenticatable.authenticate
    @authenticatable.current_user.must_be_instance_of ::User
  end
end
