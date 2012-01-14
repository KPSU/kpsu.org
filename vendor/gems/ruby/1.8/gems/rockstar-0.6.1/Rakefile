# Rakefile
require 'rubygems'
require 'rake'
require File.expand_path('../lib/rockstar/version', __FILE__)

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rockstar"
    gem.summary = %Q{wrapper for audioscrobbler (last.fm) web services}
    gem.description = %Q{This gem is an updated version of jnunemakers scrobbler gem. Rockstar uses v2.0 of the last.fm api.}
    gem.email = "bodo@bitboxer.de"
    gem.homepage = "http://github.com/bitboxer/rockstar"
    gem.authors = ["Bodo Tasche"]
    gem.add_dependency("hpricot", ">=0.4.86")
    gem.add_dependency("activesupport", ">=1.4.2")
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

#task :test => :check_dependencies

task :default => :test
