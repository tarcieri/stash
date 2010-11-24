# Stash::Hashes are remotely located lookup tables
class Stash::Hash
  include Enumerable
  
  def self.[](key)
    new(key)
  end
  
  def initialize(key, adapter = Stash.default.adapter)
    @name, @adapter = key.to_s, adapter
  end
  
  # Retrieve the value associated with a given key
  def [](key)
    @adapter.hash_get @name, key.to_s
  end
  
  # Set a value in the hash
  def []=(key, value)
    @adapter.hash_set @name, key.to_s, value.to_s
  end
  
  # Clear all elements from the hash
  def clear
    @adapter.delete @name
    self
  end
  
  # Delete a value from the hash
  def delete(key)
    @adapter.hash_delete @name, key.to_s
  end
  
  # Return the length of a hash
  def length
    @adapter.hash_length @name
  end
  
  # Is this hash empty?
  def empty?
    length == 0
  end
  
  # Cast to a Ruby hash
  def to_hash
    @adapter.hash_value @name
  end
  
  # Enumerate hashes
  def each(&block)
    to_hash.each(&block)
  end
  
  # Inspect a hash
  def inspect
    "#<Stash::Hash[:#{@name}]: #{to_hash.inspect}>"
  end
  
  # Create a string representation of a hash
  alias_method :to_s, :inspect
end