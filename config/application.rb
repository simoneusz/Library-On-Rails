require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module Library
  class Application < Rails::Application
    config.load_defaults 7.1
    config.generators do |generate|
      generate.test_framework :rspec
    end
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
