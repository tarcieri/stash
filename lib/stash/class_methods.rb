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
    
    # Obtain the class for a given adapter name
    def adapter_class(name)
      adapter_name = name.to_s.split('_').map { |s| s.capitalize }.join
      adapter_name << "Adapter"
      
      begin
        Stash.const_get adapter_name
      rescue NameError
        raise ArgumentError, "unknown adapter: #{name}"
      end
    end
  end
  
  extend ClassMethods
end