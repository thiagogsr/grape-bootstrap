$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'
require 'mongoid'

Bundler.require :default, ENV['RACK_ENV']
Mongoid.load!(File.expand_path('mongoid.yml', './config'))

Dir[File.expand_path('../../api/*.rb', __FILE__)].each do |f|
  require f
end

Dir[File.expand_path('../../app/models/*.rb', __FILE__)].each do |f|
  require f
end

require 'api'