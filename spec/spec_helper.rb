$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'stash'
require 'rspec'
require 'rspec/autorun'

# Connect to Redis
Stash.setup :default, :adapter => :redis,
                      :host => '127.0.0.1',
                      :port => 6379