# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{garb}
  s.version = "0.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Tony Pitale}]
  s.date = %q{2011-01-08}
  s.email = %q{tony.pitale@viget.com}
  s.homepage = %q{http://github.com/vigetlabs/garb}
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{viget}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Google Analytics API Ruby Wrapper}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<crack>, [">= 0.1.6"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.2.0"])
    else
      s.add_dependency(%q<crack>, [">= 0.1.6"])
      s.add_dependency(%q<activesupport>, [">= 2.2.0"])
    end
  else
    s.add_dependency(%q<crack>, [">= 0.1.6"])
    s.add_dependency(%q<activesupport>, [">= 2.2.0"])
  end
end
