ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"

Minitest::Reporters.use!([Minitest::Reporters::DefaultReporter.new(:color => true)])

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class UnitTest < ActiveSupport::TestCase
  include ActionView::Context
  include ActionView::Helpers::TagHelper
end

class FunctionalTest < ActiveSupport::TestCase
end

class ControllerTest < ActionController::TestCase # inherits from ActiveSupport::TestCase
  include Devise::TestHelpers
  setup do
    cache_dir = File.join(Rails.root, 'tmp', 'cache')
    Rails.cache.clear if File.directory?(cache_dir)
  end
end
