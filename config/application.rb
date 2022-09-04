require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Citius
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.after_initialize do
      if defined?(::Rails::Server) || "test".include?(Rails.env)
        puts 'Init hotfolder'
        Config.create_default_config if Config.count == 0
        current_config = Config.find_by(active_config: true)
        if current_config
          hotfolder = current_config.hotfolder
        else  
          hotfolder = 'results' unless hotfolder
        end  
        listener = Listen.to(hotfolder) do |modified, added, removed|
          if added.length > 0
            Rails.logger.info "call TeamResults"
            TeamResults.new.perform(added)
            Rails.logger.info "added file: #{added}"
          end
          if removed.length > 0
            Rails.logger.info "removed file : #{removed}"
          end
        end
        listener.start
      else
        puts 'Skip hotfolder'
      end    
    end
  end
end
