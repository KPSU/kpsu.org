# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{twitter_oauth}
  s.version = "0.4.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Richard Taylor}]
  s.date = %q{2010-08-11}
  s.description = %q{twitter_oauth is a Ruby client for the Twitter API using OAuth.}
  s.email = %q{moomerman@gmail.com}
  s.homepage = %q{http://github.com/moomerman/twitter_oauth}
  s.rdoc_options = [%q{--inline-source}, %q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{twitter_oauth}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{twitter_oauth is a Ruby client for the Twitter API using OAuth.}

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oauth>, [">= 0.4.1"])
      s.add_runtime_dependency(%q<json>, [">= 1.1.9"])
      s.add_runtime_dependency(%q<mime-types>, [">= 1.16"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<oauth>, [">= 0.4.1"])
      s.add_dependency(%q<json>, [">= 1.1.9"])
      s.add_dependency(%q<mime-types>, [">= 1.16"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<oauth>, [">= 0.4.1"])
    s.add_dependency(%q<json>, [">= 1.1.9"])
    s.add_dependency(%q<mime-types>, [">= 1.16"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end
