require 'bundler'
Bundler.require

require 'date'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

require_all 'lib'


