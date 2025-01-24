require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require_relative '../config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'shoulda-matchers'

Dir[Rails.root.join('spec/factories/**/*.rb')].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.include Mongoid::Matchers, type: :model
  config.include Devise::Test::ControllerHelpers

  config.include FactoryBot::Syntax::Methods
  # Remove this line to enable support for ActiveRecord
  config.use_active_record = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
