class Stash
  # Configuration error
  class ConfigError < StandardError; end
  
  module ClassMethods
    def [](key)
      default[key]
    end
  
    def setup(label, configuration)
      @configurations ||= {}
      @configurations[label.to_sym] = configuration
      @default = nil if label == :default
    end
  
    def default
      @default ||= begin
        raise ConfigError, "please configure me with Stash.setup" unless @configurations
        raise ConfigError, "no default configuration" unless @configurations[:default]
        new(@configurations[:default])
      end
    end
  end
  
  extend ClassMethods
end