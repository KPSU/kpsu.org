# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{musicbrainz-ruby}
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Robin Tweedie}]
  s.date = %q{2011-02-02}
  s.email = %q{robin@songkick.com}
  s.extra_rdoc_files = [%q{README.markdown}]
  s.files = [%q{README.markdown}]
  s.homepage = %q{https://github.com/dwo/musicbrainz-ruby}
  s.rdoc_options = [%q{--main}, %q{README.markdown}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Simple Ruby wrapper for MusicBrainz XML Web Service}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.7.3"])
      s.add_runtime_dependency(%q<hashie>, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>, [">= 2.4"])
      s.add_development_dependency(%q<fakeweb>, [">= 1.3"])
    else
      s.add_dependency(%q<httparty>, [">= 0.7.3"])
      s.add_dependency(%q<hashie>, ["~> 1.0"])
      s.add_dependency(%q<rspec>, [">= 2.4"])
      s.add_dependency(%q<fakeweb>, [">= 1.3"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.7.3"])
    s.add_dependency(%q<hashie>, ["~> 1.0"])
    s.add_dependency(%q<rspec>, [">= 2.4"])
    s.add_dependency(%q<fakeweb>, [">= 1.3"])
  end
end
