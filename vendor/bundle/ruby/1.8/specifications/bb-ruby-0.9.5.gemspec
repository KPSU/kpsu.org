# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bb-ruby}
  s.version = "0.9.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Craig P Jolicoeur}]
  s.date = %q{2010-02-26}
  s.description = %q{BBRuby is a BBCode (http://www.bbcode.org) implementation for Ruby. It will convert strings with BBCode markup to their HTML equivalent.}
  s.email = [%q{cpjolicoeur@gmail.com}]
  s.extra_rdoc_files = [%q{History.txt}, %q{Manifest.txt}, %q{PostInstall.txt}]
  s.files = [%q{History.txt}, %q{Manifest.txt}, %q{PostInstall.txt}]
  s.homepage = %q{http://bb-ruby.rubyforge.org}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = [%q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{bb-ruby}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{BBRuby is a BBCode (http://www.bbcode.org) implementation for Ruby}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.5.2"])
      s.add_development_dependency(%q<hoe>, [">= 2.3.2"])
    else
      s.add_dependency(%q<newgem>, [">= 1.5.2"])
      s.add_dependency(%q<hoe>, [">= 2.3.2"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.5.2"])
    s.add_dependency(%q<hoe>, [">= 2.3.2"])
  end
end
