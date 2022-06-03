require 'simplecov'
SimpleCov.add_filter ["spec/", "lib/contentstack_utils/support"]
require 'image_extension'
require_relative './mock/constant'
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/mock/**/*.rb'].each { |f| require f }
