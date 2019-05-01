ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'webmock/rspec'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!
WebMock.disable_net_connect!
Sidekiq::Testing.inline!
Sidekiq::Logging.logger = nil

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include ActiveSupport::Testing::TimeHelpers
  config.include ControllerSpecsHelper

  config.before :example, type: :controller do
    spec        = OasParser::Definition.resolve(Rails.root.join('swagger', 'v1', 'swagger.json'))
    schema_data = spec.path_by_path(schema_path).endpoint_by_method(schema_method).response_by_code(code.to_s).raw["schema"]
    @schema     = JsonSchema.parse!(schema_data) if schema_data
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation, { except: %w(countries areas) }
    DatabaseCleaner.strategy   = :transaction
    DatabaseCleaner[:redis].db = 'redis://localhost:6379/2'
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
    DatabaseCleaner[:redis].clean
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec::Sidekiq.configure do |config|
  config.warn_when_jobs_not_processed_by_sidekiq = false
end

def attachment_fixture(name)
  File.open(Rails.root.join('spec', 'fixtures', 'files', name))
end

def body_as_json
  json_str_to_hash(response.body)
end

def json_str_to_hash(str)
  JSON.parse(str, symbolize_names: true)
end
