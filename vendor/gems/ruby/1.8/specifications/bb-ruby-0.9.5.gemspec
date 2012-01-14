# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bb-ruby}
  s.version = "0.9.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Craig P Jolicoeur"]
  s.date = %q{2010-02-26}
  s.description = %q{BBRuby is a BBCode (http://www.bbcode.org) implementation for Ruby. It will convert strings with BBCode markup to their HTML equivalent.}
  s.email = ["cpjolicoeur@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/bb-ruby.rb", "test/test_bb-ruby.rb", "test/test_helper.rb"]
  s.homepage = %q{http://bb-ruby.rubyforge.org}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{bb-ruby}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{BBRuby is a BBCode (http://www.bbcode.org) implementation for Ruby}
  s.test_files = ["test/test_bb-ruby.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
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
