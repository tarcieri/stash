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
    @adapter.list_range @key, 0, length
  end
  alias_method :to_a, :to_ary
  
  # Get the length of a list
  def length
    @adapter.list_length(@key)
  end
  
  # Is this list empty?
  def empty?
    length == 0
  end
  
  # Clear all elements from the list
  def clear
    @adapter.delete @key
    self
  end
  
  # Push an element onto the list (i.e. right push)
  def push(elem)
    @adapter.list_push @key, elem.to_s, :right
    self
  end
  alias_method :<<, :push
  alias_method :rpush, :push
  
  # Unshift an element onto the list (i.e. left push)
  def unshift(elem)
    @adapter.list_push @key, elem.to_s, :left
  end
  alias_method :lpush, :unshift
  
  # Pop from a list (i.e. right pop)
  def pop
    @adapter.list_pop @key, :right
  end
  alias_method :rpop, :pop
  
  # Shift from a list (i.e. left pop)
  def shift
    @adapter.list_pop @key, :left
  end
  alias_method :lpop, :shift
  
  # Iterate the list
  def each(&block)
    to_ary.each(&block)
  end
  
  # Obtain the last element in a list
  def last
    to_ary[-1]
  end
  
  # Inspect a list
  def inspect
    "#<Stash::List[:#{@key}]: #{to_ary.inspect}>"
  end
  
  # Create a string representation of a list
  alias_method :to_s, :inspect
end