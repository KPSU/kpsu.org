# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sqlite3}
  s.version = "1.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Jamis Buck}, %q{Luis Lavena}, %q{Aaron Patterson}]
  s.date = %q{2011-01-16}
  s.description = %q{This module allows Ruby programs to interface with the SQLite3
database engine (http://www.sqlite.org).  You must have the
SQLite engine installed in order to build this module.

Note that this module is NOT compatible with SQLite 2.x.}
  s.email = [%q{jamis@37signals.com}, %q{luislavena@gmail.com}, %q{aaron@tenderlovemaking.com}]
  s.extensions = [%q{ext/sqlite3/extconf.rb}]
  s.extra_rdoc_files = [%q{Manifest.txt}, %q{API_CHANGES.rdoc}, %q{CHANGELOG.rdoc}, %q{README.rdoc}, %q{ext/sqlite3/backup.c}, %q{ext/sqlite3/database.c}, %q{ext/sqlite3/exception.c}, %q{ext/sqlite3/sqlite3.c}, %q{ext/sqlite3/statement.c}]
  s.files = [%q{Manifest.txt}, %q{API_CHANGES.rdoc}, %q{CHANGELOG.rdoc}, %q{README.rdoc}, %q{ext/sqlite3/backup.c}, %q{ext/sqlite3/database.c}, %q{ext/sqlite3/exception.c}, %q{ext/sqlite3/sqlite3.c}, %q{ext/sqlite3/statement.c}, %q{ext/sqlite3/extconf.rb}]
  s.homepage = %q{http://github.com/luislavena/sqlite3-ruby}
  s.rdoc_options = [%q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = %q{sqlite3}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{This module allows Ruby programs to interface with the SQLite3 database engine (http://www.sqlite.org)}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>, ["~> 0.7.0"])
      s.add_development_dependency(%q<hoe>, [">= 2.8.0"])
    else
      s.add_dependency(%q<rake-compiler>, ["~> 0.7.0"])
      s.add_dependency(%q<hoe>, [">= 2.8.0"])
    end
  else
    s.add_dependency(%q<rake-compiler>, ["~> 0.7.0"])
    s.add_dependency(%q<hoe>, [">= 2.8.0"])
  end
end
