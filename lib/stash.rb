# Stash is an abstract interface to data structures servers
class Stash
  attr_reader :adapter
  
  # Timeout when performing a blocking action, such as blocking pop
  class TimeoutError < StandardError; end
  
  def initialize(config)
    raise ArgumentError, "no adapter specified" unless config[:adapter]
    @adapter = Stash.adapter_class(config[:adapter]).new config
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
require 'stash/hash'