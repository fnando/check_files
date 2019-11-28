# frozen_string_literal: true

module CheckFiles
  class Railtie < Rails::Railtie
    config.check_files = ActiveSupport::OrderedOptions.new

    initializer "check_files" do
      config.check_files.paths = [
        "Gemfile.lock",
        "config/initializers/**/*.rb",
        "config/{application,boot,config,environment}.rb",
        "config/*.yml",
        "config/environments/**/*.rb",
        "app/*",
        "config/locales/**/*"
      ]

      Rails.application.config.middleware.use(Middleware)
      config.check_files.notifier = if Rails::VERSION::STRING >= "5.0.0"
                                      Notifiers::Restart
                                    else
                                      Notifiers::Exception
                                    end

      Rails.application.config.after_initialize do
        CheckFiles.checkers.each(&:update_cache)
      end
    end
  end
end
