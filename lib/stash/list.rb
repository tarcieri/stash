# Stash::Lists are (mostly) ordered lists stored remotely on the server
class Stash::List
  include Enumerable
  
  def self.[](key)
    new(key)
  end
  
  def initialize(key, adapter = Stash.default.adapter)
    @key, @adapter = key.to_s, adapter
  end
  
  # Cast to an array
  def to_ary
    @adapter.list_range @key, 0, @adapter.list_length(@key)
  end
  alias_method :to_a, :to_ary
  
  # Clear all elements from the list
  def clear
    @adapter.delete @key
    self
  end
  
  # Push an element onto the list
  def push(elem)
    @adapter.list_push @key, elem.to_s
    self
  end
  alias_method :<<, :push
  
  # Iterate the list
  def each(&block)
    to_ary.each(&block)
  end
  
  # Inspect a list
  def inspect
    "#<Stash::List[:#{@key}]: #{to_ary.inspect}>"
  end
  
  # Create a string representation of a list
  alias_method :to_s, :inspect
end