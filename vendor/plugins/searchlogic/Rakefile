require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rd_searchlogic"
    gem.summary = "Searchlogic makes using ActiveRecord named scopes easier and less repetitive."
    gem.description = "Searchlogic makes using ActiveRecord named scopes easier and less repetitive."
    gem.email = "bjohnson@binarylogic.com"
    gem.homepage = "http://github.com/railsdog/searchlogic"
    gem.authors = ["Ben Johnson of Binary Logic", "Roman Smirnov of RailsDog"]
    gem.rubyforge_project = "searchlogic"
    gem.add_dependency "activerecord", ">= 3.0.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList[
    #'spec/**/conditions_spec.rb',
    #'spec/**/ordering_conditions_spec.rb',
    'spec/**/association_conditions_spec.rb'
    #'spec/**/association_ordering_spec.rb'
    #'spec/**/search_spec.rb'
    #'spec/**/*_spec.rb'
    ]
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec
