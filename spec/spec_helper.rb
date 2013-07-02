# encoding: UTF-8

require 'active_record'
require 'minitest/autorun'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'memory')

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, force: true do |t|
    t.string  :username
    t.string  :password
  end
end
