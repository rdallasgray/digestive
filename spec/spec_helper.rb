# encoding: UTF-8

require 'active_record'
require 'minitest/autorun'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'memory')

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, force: true do |t|
    t.string  :name
    t.string  :username
    t.string  :password
    t.integer :role_id
  end

  create_table :roles, force: true do |t|
    t.string  :name
    t.integer :privilege_level
  end

  create_table :admin_sessions, force: true do |t|
    t.integer :user_id
    t.string  :logged_in_at
    t.string  :logged_out_at
  end
end
