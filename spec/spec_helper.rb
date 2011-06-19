# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
#require 'spec/autorun'
#require 'spec/rails'
require 'spec/rspec_rails_mocha'
require 'factory_girl'
require 'email_spec'

#require File.expand_path(File.join(File.dirname(__FILE__),'ext','rspec-rails', 'controller_example_group.rb'))

# Uncomment the next line to use webrat's matchers
#require 'webrat/integrations/rspec-rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

# shared behaviors
#
# Please drop your shared behavior files in spec/shared so we don't clutter this
# file with them. All you need to do in this file is include them below.
if File.directory?(File.expand_path(File.join(File.dirname(__FILE__), "shared")))
  Dir[File.expand_path(File.join(File.dirname(__FILE__), "shared", "*.rb"))].each { |file| require file }
end

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses its own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  #
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner
  
  # == Shared Behaviors
  #
  # Include your shared behaviors here. The :type argument is optional.
  #config.include(Shared::LoginTester, :type => :controllers)
  config.include(Shared::CookieTester, :type => :controllers)
  config.include(Shared::PostsGenerator)
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
  config.include(Shared::SeleniumTestUtilities)
#  config.include(Shared::PostsView)
  config.include(Shared::ModelGenerator)
end
