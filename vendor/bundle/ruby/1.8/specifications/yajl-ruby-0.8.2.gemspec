# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{yajl-ruby}
  s.version = "0.8.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Brian Lopez}, %q{Lloyd Hilaiel}]
  s.date = %q{2011-03-23}
  s.email = %q{seniorlopez@gmail.com}
  s.extensions = [%q{ext/yajl/extconf.rb}]
  s.extra_rdoc_files = [%q{README.rdoc}]
  s.files = [%q{README.rdoc}, %q{ext/yajl/extconf.rb}]
  s.homepage = %q{http://github.com/brianmario/yajl-ruby}
  s.require_paths = [%q{lib}, %q{ext}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Ruby C bindings to the excellent Yajl JSON stream-based parser library.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>, [">= 0.7.5"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_development_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<rake-compiler>, [">= 0.7.5"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake-compiler>, [">= 0.7.5"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
  end
end
