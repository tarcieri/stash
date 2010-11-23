class Stash
  class << self
    def self.[](key)
      default[key]
    end
    
    def setup(label, configuration)
      @configurations ||= {}
      @configurations[label.to_sym] = configuration
    end
    
    def default
      @default ||= begin
        raise "no default configuration" unless @configurations[:default]
        new(@configurations[:default])
      end
    end
  end
  
  def initialize(config)
    raise ArgumentError, "no adapter specified" unless config[:adapter]
    adapter_name  = config[:adapter].to_s.split('_').map { |s| s.capitalize }.join
    
    begin
      adapter_class = Stash.const_get adapter_name
    rescue NameError
      raise ArgumentError, "unknown adapter: #{config[:adapter]}"
    end
    
    @adapter = adapter_class.new config
  end
end