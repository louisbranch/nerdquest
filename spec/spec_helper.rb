require 'rspec'
require 'rack/test'
require 'simplecov'
SimpleCov.start

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.mock_with :rspec
end

