# encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../lib/digestive/auth'
require_relative '../../lib/digestive/user'

describe Digestive::Auth do

  class Authenticatable
    include Digestive::Auth
  end

  before do
    @authenticatable = Authenticatable.new
  end

  it 'should provide a convenience method' do
    service = Digestive::Auth::Service.new(User)
    Digestive::Auth::Service.expects(:new).with(Digestive::User, nil)
      .returns(service)
    service.expects(:authenticate)
    @authenticatable.authenticate
  end
end
