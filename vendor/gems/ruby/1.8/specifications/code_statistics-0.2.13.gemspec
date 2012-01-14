# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{code_statistics}
  s.version = "0.2.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Mayer"]
  s.date = %q{2010-03-02}
  s.default_executable = %q{code_statistics}
  s.description = %q{"This is a port of the rails 'rake stats' method so it can be made more robust and work for non rails projects. New features may eventually be added as well."}
  s.email = %q{dan@devver.net}
  s.executables = ["code_statistics"]
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = [".document", ".gitignore", "LICENSE", "README.rdoc", "Rakefile", "VERSION", "bin/code_statistics", "code_statistics.gemspec", "lib/code_statistics.rb", "lib/code_statistics/code_statistics.rb", "lib/tasks/code_stats.rb", "test/code_statistics_test.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/danmayer/code_statistics}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Making a gem of the normal rails rake stats method, to make it more robust and work on non rails projects}
  s.test_files = ["test/code_statistics_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_development_dependency(%q<test-construct>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<test-construct>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<test-construct>, [">= 0"])
  end
end
