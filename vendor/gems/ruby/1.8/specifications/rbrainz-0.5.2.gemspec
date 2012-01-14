# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rbrainz}
  s.version = "0.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Philipp Wolfer}, %q{Nigel Graham}]
  s.date = %q{2011-04-27}
  s.description = %q{    RBrainz is a Ruby client library to access the MusicBrainz XML
    web service. RBrainz supports the MusicBrainz XML Metadata Version 1.2,
    including support for labels and extended release events.
    
    RBrainz follows the design of python-musicbrainz2, the reference
    implementation for a MusicBrainz client library. Developers used to
    python-musicbrainz2 should already know most of RBrainz' interface.
    However, RBrainz differs from python-musicbrainz2 wherever it makes
    the library more Ruby like or easier to use.
}
  s.email = %q{phw@rubyforge.org}
  s.extra_rdoc_files = [%q{doc/README.rdoc}, %q{LICENSE}, %q{TODO}, %q{CHANGES}]
  s.files = [%q{doc/README.rdoc}, %q{LICENSE}, %q{TODO}, %q{CHANGES}]
  s.homepage = %q{http://rbrainz.rubyforge.org}
  s.require_paths = [%q{lib}]
  s.requirements = [%q{Optional: mb-discid >= 0.1.2 (for calculating disc IDs)}]
  s.rubyforge_project = %q{rbrainz}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Ruby library for the MusicBrainz XML web service.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
