# Strings are Stash's most basic type, and the only non-collection type
# They store exactly that, a string, and nothing more
class Stash::String
  def initialize(key, adapter = Stash.default.adapter)
    @adapter, @key = adapter, key.to_s
  end
  
  def to_string
    @adapter.get @key
  end
  alias_method :to_s, :to_string
  
  def inspect
    "#<Stash::String[:#{key}]: #{to_s}>"
  end
end