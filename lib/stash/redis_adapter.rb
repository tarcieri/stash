require 'redis'
require 'redis-namespace'

class Stash
  # Adapter for the Redis data structures server. 
  # See http://code.google.com/p/redis/
  class RedisAdapter
    attr_reader :capabilities
    
    def initialize(config)
      # Symbolize keys in config
      config = config.inject({}) { |h, (k, v)| h[k.to_sym] = v; h }
      
      raise ArgumentError, "missing 'host' key" unless config[:host]
      config[:port] ||= 6379 # Default Redis port
      
      redis = Redis.new config
      redis = Redis::Namespace.new config[:namespace], :redis => redis if config[:namespace]
      
      @capabilities = [:string]
      @redis = redis
    end
    
    # Set a given key within Redis
    def []=(key, value)
      @redis.set key.to_s, value.to_s
    end
    
    # Retrieve a given key from Redis
    def [](key)
      case type(key)
      when "none"   then nil
      when "string" then Stash::String.new key, @redis
      else raise "unknown Redis key type: #{key}"
      end
    end
    
    # Retrieve the type for a given key
    def type(key)
      @redis.type key.to_s
    end
    
    # Retrieve a key as a string
    def get(key)
      @redis.get key.to_s
    end
    
    # Delete a key
    def delete(key)
      @redis.del key.to_s
    end
  end
end