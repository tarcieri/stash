# Stash is an abstract interface to data structures servers
class Stash
  attr_reader :adapter
  
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
  
  # Store an object in the Stash
  def []=(key, value)
    @adapter[key.to_s] = value
  end
  
  # Retrieve an object from the Stash
  def [](key)
    @adapter[key.to_s]
  end
  
  # Remove a key from the Stash
  def delete(key)
    @adapter.delete(key.to_s)
    true
  end
end

require 'stash/class_methods'
require 'stash/redis_adapter'
require 'stash/string'
require 'stash/list'