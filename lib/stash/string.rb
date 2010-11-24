class Stash
  # Strings are Stash's most basic type, and the only non-collection type
  # They store exactly that, a string, and nothing more
  class String
    def initialize(key, adapter = Stash.default)
      @adapter, @key = adapter, key.to_s
    end
    
    def to_s
      @adapter.get @key
    end
    
    def inspect
      "#<Stash::String: #{to_s}>"
    end
  end
end