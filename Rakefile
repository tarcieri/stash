require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "stash"
    gem.summary = "Abstract interface to data structures servers"
    gem.description = "Stash maps the facilities provided by data structures servers onto classes which mimic Ruby's built-in types"
    gem.email = "tony@medioh.com"
    gem.homepage = "http://github.com/tarcieri/stash"
    gem.authors = ["Tony Arcieri"]
    gem.add_dependency "redis", "~> 2.1.0"
    gem.add_dependency "redis-namespace", "~> 0.10.0"
    gem.add_development_dependency "rspec", "~> 2.1.0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:rspec) do |rspec|
  rspec.rspec_opts = %w[-fs -c -b]
end

RSpec::Core::RakeTask.new(:rspec) do |rspec|
  rspec.rspec_opts = %w[-fs -c -b]
  rspec.rcov = true
end

task :rspec => :check_dependencies
task :spec  => :rspec

task :default => :rspec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "stash #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
