# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{flickr}
  s.version = "1.0.2"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Scott Raymond, Patrick Plattes}]
  s.autorequire = %q{flickr}
  s.cert_chain = nil
  s.date = %q{2008-02-26}
  s.email = %q{patrick@erdbeere.net}
  s.homepage = %q{http://flickr.rubyforge.org/}
  s.require_paths = [%q{.}]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.requirements = [%q{Flickr developers API key}]
  s.rubyforge_project = %q{flickr}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{An insanely easy interface to the Flickr photo-sharing service. By Scott Raymond. Maintainer: Patrick Plattes}

  if s.respond_to? :specification_version then
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<xml-simple>, [">= 1.0.7"])
    else
      s.add_dependency(%q<xml-simple>, [">= 1.0.7"])
    end
  else
    s.add_dependency(%q<xml-simple>, [">= 1.0.7"])
  end
end
