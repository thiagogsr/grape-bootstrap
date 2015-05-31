require File.expand_path('../../config/environment', __FILE__)
require 'rspec'
require 'rack/test'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'

Dir[File.expand_path('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.order = :random
end