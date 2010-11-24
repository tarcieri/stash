class Stash
  # Strings are Stash's most basic type, and the only non-collection type
  # They store exactly that, a string, and nothing more
  class String
    def initialize(key)
      @key = key.to_s
    end
  end
end