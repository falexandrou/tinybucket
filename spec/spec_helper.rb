require 'rubygems'
require 'bundler/setup'

require 'tinybucket'
require 'rspec'
require 'webmock/rspec'

require 'pry'

require 'simplecov'
SimpleCov.start do
  add_filter '.bundle/'
  add_filter 'spec'
end

path = Pathname.new(Dir.pwd)
Dir[path.join('spec/support/**/*.rb')].each { |f| require f }

# configure tinybucket logger.
logger = Logger.new('log/test.log')
logger.level = Logger::DEBUG
Tinybucket.logger = logger

RSpec.configure do |config|

  config.order = 'random'
end
