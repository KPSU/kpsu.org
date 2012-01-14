# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{musicbrainz_automatcher}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Patrick Sinclair}]
  s.date = %q{2011-06-05}
  s.email = %q{metade@gmail.com}
  s.extra_rdoc_files = [%q{README}]
  s.files = [%q{README}]
  s.homepage = %q{http://github.com/metade/musicbrainz_automatcher}
  s.rdoc_options = [%q{--main}, %q{README}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{musicbrainz_automatcher}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{musicbrainz_automatcher matches artists/tracks names to MusicBrainz intelligently}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<text>, ["~> 0.2"])
      s.add_runtime_dependency(%q<rbrainz>, ["~> 0.5.1"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<text>, ["~> 0.2"])
      s.add_dependency(%q<rbrainz>, ["~> 0.5.1"])
      s.add_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<text>, ["~> 0.2"])
    s.add_dependency(%q<rbrainz>, ["~> 0.5.1"])
    s.add_dependency(%q<activesupport>, ["~> 3.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end
