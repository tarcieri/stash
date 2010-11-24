# Stash is an abstract interface to data structures servers
class Stash  
  def initialize(config)
    raise ArgumentError, "no adapter specified" unless config[:adapter]
    adapter_name  = config[:adapter].to_s.split('_').map { |s| s.capitalize }.join
    adapter_name += "Adapter"  
    
    begin
      adapter_class = Stash.const_get adapter_name
    rescue NameError
      raise ArgumentError, "unknown adapter: #{config[:adapter]}"
    end
    
    @adapter = adapter_class.new config
  end
end

require 'stash/class_methods'
require 'stash/redis_adapter'