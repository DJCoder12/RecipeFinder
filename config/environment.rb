require 'bundler'

Bundler.require

@environment = ENV['RACK_ENV'] || 'development'

require_all 'app'
