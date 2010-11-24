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
      
      [:host, :port].each do |key|
        raise ArgumentError, "missing redis configuration option: #{key}" unless config[key]
      end
      
      redis = Redis.new config
      redis = Redis::Namespace.new config[:namespace], :redis => redis if config[:namespace]
      
      @capabilities = [:string]
      @redis = redis
    end
  end
end