class Stash
  # Configuration error
  class ConfigError < StandardError; end
  
  module ClassMethods
    def [](key)
      default[key]
    end
    
    def []=(key, value)
      default[key] = value
    end
    
    # Add a configuration entry to Stash
    def setup(label, configuration)
      @configurations ||= {}
      @configurations[label.to_sym] = configuration
      
      if label == :default
        @default = nil
        default
      end
    end
  
    # Retrieve the default Stash configuration
    def default
      @default ||= begin
        raise ConfigError, "please configure me with Stash.setup" unless @configurations
        raise ConfigError, "no default configuration" unless @configurations[:default]
        new(@configurations[:default])
      end
    end
    
    # Retrieve a particular Stash configuration
    def configuration(key)
      @configurations[key.to_sym]
    end
    
    # Delete a key from the Stash
    def delete(key)
      default.delete(key)
      true
    end
  end
  
  extend ClassMethods
end