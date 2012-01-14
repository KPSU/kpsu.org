# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{juggernaut}
  s.version = "2.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Alex MacCaw}]
  s.date = %q{2011-06-06}
  s.description = %q{Use Juggernaut to easily implement realtime chat, collaboration, gaming and much more!}
  s.email = %q{info@eribium.org}
  s.homepage = %q{http://github.com/maccman/juggernaut}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Simple realtime push}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redis>, [">= 0"])
    else
      s.add_dependency(%q<redis>, [">= 0"])
    end
  else
    s.add_dependency(%q<redis>, [">= 0"])
  end
end
