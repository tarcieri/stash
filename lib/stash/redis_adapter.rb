require 'redis'
require 'redis-namespace'

class Stash
  # Adapter for the Redis data structures server. 
  # See http://code.google.com/p/redis/
  class RedisAdapter    
    def initialize(config)
      # Convert config keys to symbols
      config = symbolize_config(config)
      
      raise ArgumentError, "missing 'host' key" unless config[:host]
      config[:port] ||= 6379 # Default Redis port
      
      @config = config
    end

    # Obtain a connection to Redis
    def connection
      redis = Redis.new @config
      redis = Redis::Namespace.new @config[:namespace], :redis => redis if @config[:namespace]
      
      begin
        yield redis
      ensure
        redis.quit
      end
    end
    
    # Set a given key within Redis
    def []=(key, value)
      connection { |redis| redis.set key.to_s, value.to_s }
    end
    
    # Retrieve a given key from Redis
    def [](key)
      case type(key)
      when "none"   then nil
      when "string" then Stash::String.new key, self
      when "list"   then Stash::List.new   key, self
      else raise "unknown Redis key type: #{key}"
      end
    end
    
    # Retrieve the type for a given key
    def type(key)
      connection { |redis| redis.type key.to_s }
    end
    
    # Retrieve a key as a string
    def get(key)
      connection { |redis| redis.get key.to_s }
    end
    
    # Delete a key
    def delete(key)
      connection { |redis| redis.del key.to_s }
    end
    
    # Push an element onto a list
    def list_push(name, value, side)
      connection do |redis|
        case side
        when :right
          redis.rpush name.to_s, value.to_s
        when :left
          redis.lpush name.to_s, value.to_s
        else raise ArgumentError, "left or right plztks"
        end
      end
    end
        
    # Pop from a list
    def list_pop(name, side)
      connection do |redis|
        case side
        when :right
          redis.rpop name.to_s
        when :left
          redis.lpop name.to_s
        else raise ArgumentError, "left or right plztks"
        end
      end
    end
    
    # Blocking pop from a list
    def list_blocking_pop(name, side, timeout = nil)
      connection do |redis|
        timeout ||= 0
        res = case side
        when :left
          redis.blpop name, timeout
        when :right
          redis.brpop name, timeout
        else raise ArgumentError, "left or right plztks"
        end
      
        return res[1] if res
        raise Stash::TimeoutError, "request timed out"
      end
    end
    
    # Retrieve the length of a list
    def list_length(name)
      connection { |redis| redis.llen name.to_s }
    end
    
    # Retrieve the given range from a list
    def list_range(name, from, to)
      connection { |redis| redis.lrange name.to_s, from, to }
    end
    
    # Retrieve a value from a hash
    def hash_get(name, key)
      res = connection { |redis| redis.hget name.to_s, key.to_s }
      return if res == ""
      res
    end
    
    # Store a value in a hash
    def hash_set(name, key, value)
      connection { |redis| redis.hset name.to_s, key.to_s, value.to_s }
    end
    
    # Retrieve the contents of a hash as a Ruby hash
    def hash_value(name)
      connection { |redis| redis.hgetall name.to_s }
    end
    
    # Delete an entry from a hash
    def hash_delete(name, key)
      connection { |redis| redis.hdel name.to_s, key.to_s }
    end
    
    # Return the length of a hash
    def hash_length(name)
      connection { |redis| redis.hlen name.to_s }
    end
    
    #######
    private
    #######
    
    def symbolize_config(config)
      new_config = {}
      config.each do |k, v|
        new_config[k.to_sym] = v
      end
      new_config
    end
  end
end