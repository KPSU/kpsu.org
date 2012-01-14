# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{loggable}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Patrick Reagan}]
  s.date = %q{2009-04-29}
  s.email = %q{patrick.reagan@viget.com}
  s.extra_rdoc_files = [%q{README.rdoc}]
  s.files = [%q{README.rdoc}]
  s.homepage = %q{http://viget.com/extend}
  s.rdoc_options = [%q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{viget}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{A gem that provides logging capabilities to any class}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
