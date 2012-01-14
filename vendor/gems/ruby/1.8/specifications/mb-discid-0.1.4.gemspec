# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mb-discid}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Philipp Wolfer}]
  s.autorequire = %q{mb-discid}
  s.date = %q{2009-11-18}
  s.description = %q{    Ruby bindings for libdiscid. See http://musicbrainz.org/doc/libdiscid
    for more information on libdiscid and MusicBrainz.
}
  s.email = %q{phw@rubyforge.org}
  s.extensions = [%q{ext/extconf.rb}]
  s.extra_rdoc_files = [%q{README}, %q{LICENSE}, %q{CHANGES}]
  s.files = [%q{README}, %q{LICENSE}, %q{CHANGES}, %q{ext/extconf.rb}]
  s.homepage = %q{http://rbrainz.rubyforge.org}
  s.require_paths = [%q{lib}, %q{ext}]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.requirements = [%q{libdiscid (http://musicbrainz.org/doc/libdiscid)}]
  s.rubyforge_project = %q{rbrainz}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Ruby bindings for libdiscid.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
