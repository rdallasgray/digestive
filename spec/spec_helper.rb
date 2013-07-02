# encoding: UTF-8

gem 'activerecord'

require 'active_record'
require 'minitest/autorun'
require 'mocha/setup'

class User
  DIGEST_REALM = 'test'
  def self.find_by_username(username)
    self.new
  end
  def password
    'test'
  end
end

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'memory')

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, force: true do |t|
    t.string  :username
    t.string  :password
  end
end
