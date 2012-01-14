# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fleakr}
  s.version = "0.6.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Patrick Reagan}]
  s.date = %q{2009-12-28}
  s.email = %q{reaganpr@gmail.com}
  s.extra_rdoc_files = [%q{README.rdoc}]
  s.files = [%q{README.rdoc}]
  s.homepage = %q{http://sneaq.net}
  s.rdoc_options = [%q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{A small, yet powerful, gem to interface with Flickr photostreams}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, [">= 0.6.164"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.0"])
      s.add_runtime_dependency(%q<loggable>, [">= 0.2.0"])
    else
      s.add_dependency(%q<hpricot>, [">= 0.6.164"])
      s.add_dependency(%q<activesupport>, [">= 2.0"])
      s.add_dependency(%q<loggable>, [">= 0.2.0"])
    end
  else
    s.add_dependency(%q<hpricot>, [">= 0.6.164"])
    s.add_dependency(%q<activesupport>, [">= 2.0"])
    s.add_dependency(%q<loggable>, [">= 0.2.0"])
  end
end
