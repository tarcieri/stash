Stash
=====

*"The sloping companion I cast down the ash, yanked on my tunic and dangled my stash"*

Stash provides Ruby-like classes for interacting with data structures servers.
Presently the only such server supported is Redis, however support is planned
for Membase, Memcache, and possibly Kestrel.

Initializing Stash
------------------

Stash supports multiple connections which are initialized through the
stash Stash.setup command. Stash operates primarily through the default
connection:

    Stash.setup :default, :adapter => :redis, :host => 'localhost'
    
This will connect to the Redis server listening on localhost. Stash.setup
takes an options hash with the following parameters:

- **adapter**: must be "redis"
- **host**: hostname or IP address of the Redis server (*mandatory*)
- **port**: port of the Redis server (*optional, default 6379*)
- **namespace**: Redis namspace to use (*optional, default global namespace*)
- **password**: password to the Redis server (*optional*)

Strings
-------

The core type exposed by Stash is a string. You can store a string in the
default Stash using:

    Stash[:foobar] = "mystring"
    
This string can be retrieved as easily as:

    Stash[:foobar]
    
And deleted with:

    Stash.delete :foobar
    
Lists
-----

Stash supports a (mostly) ordered list type. You can retrieve a list with:

    Stash::List[:baz]
    
Stash Lists support most of the methods you'd expect on the Ruby Array type.
They are enumerable and support all of Ruby's Enumerable methods.

You can push elements onto the list with:

    Stash::List[:baz] << 'asdf'
    
And pop them with:

    Stash::List[:baz].pop
    
Lists can be converted to arrays with:

    Stash::List[:baz].to_a
    
Or iterated with:

    Stash::List[:baz].each { |elem| ... }
    
Hashes
------

Stash hashes work like Ruby hashes. You can retrieve a Stash::Hash with:

    Stash::Hash[:qux]
    
You can set members of a Stash::Hash with:

    Stash::Hash[:qux][:omgwtf] == "bbq"
   
or retrieve them with:

    Stash::Hash[:qux][:omgwtf]
    
You can convert a Stash::Hash to a Ruby hash with:

    Stash::Hash[:qux].to_hash