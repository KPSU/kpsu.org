# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{time_of_day}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lailson Bandeira"]
  s.date = %q{2010-12-26}
  s.description = %q{Adds time-only capabilities to the Time class and maps the Rails time type correctly to a time without date.}
  s.email = %q{lailson@guava.com.br}
  s.files = [".document", ".gitignore", "Gemfile", "LICENSE", "README.rdoc", "Rakefile", "lib/time_of_day.rb", "lib/time_of_day/ext/active_record.rb", "lib/time_of_day/ext/time.rb", "lib/time_of_day/version.rb", "test/helper.rb", "test/test_active_record_extensions.rb", "test/test_time_extensions.rb", "time_of_day.gemspec"]
  s.homepage = %q{http://rubygems.org/gems/time_of_day}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{time_of_day}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Handle correctly times without dates in Rails 3.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<shoulda>, [">= 2.11.3"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<activerecord>, [">= 3.0.0"])
    else
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<shoulda>, [">= 2.11.3"])
      s.add_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_dependency(%q<activerecord>, [">= 3.0.0"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<shoulda>, [">= 2.11.3"])
    s.add_dependency(%q<activesupport>, [">= 3.0.0"])
    s.add_dependency(%q<activerecord>, [">= 3.0.0"])
  end
end
