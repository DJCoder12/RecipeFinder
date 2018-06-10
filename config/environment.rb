require 'bundler'

Bundler.require

@environment = ENV['RACK_ENV'] || 'development'
@dbconfig = YAML.load(File.read('config/database.yml'))

ActiveRecord::Base.establish_connection @dbconfig[@environment]

require_all 'app'
