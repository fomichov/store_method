require 'rubygems'
require 'bundler'
require 'logger'
require 'rspec'
require 'active_record'
require 'database_cleaner'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
require 'store_method'

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
ActiveRecord::Base.configurations = YAML::load_file(File.dirname(__FILE__) + '/database.yml')
ActiveRecord::Base.establish_connection(:sqlite3)

load(File.dirname(__FILE__) + '/schema.rb')
load(File.dirname(__FILE__) + '/user.rb')

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding :exclude => true

  config.mock_with :rspec

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
