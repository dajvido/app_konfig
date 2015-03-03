require "active_support/ordered_options"
require "yaml"
require "erb"

require "app_konfig/version"

module AppKonfig
  class Config < ActiveSupport::OrderedOptions
    DEFAULT_ENV = "development"
    CONFIG_PATH = {
      public: './config/config.yml',
      secret: './config/secrets.yml',
    }

    def initialize
      super
      deep_merge!(pub_config).deep_merge!(sec_config)
    end

    def pub_config
      load_config(CONFIG_PATH[:public])
    end

    def sec_config
      load_config(CONFIG_PATH[:secret]) rescue {}
    end

    def load_config path
      YAML.load(ERB.new(File.read(path)).result).fetch(env)
    end

    def env
      ENV.fetch("RAILS_ENV"){ DEFAULT_ENV }
    end
  end
end

AppConfig = AppKonfig::Config.new
