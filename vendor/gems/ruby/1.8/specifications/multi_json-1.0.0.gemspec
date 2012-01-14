# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{multi_json}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Bleigh"]
  s.date = %q{2011-04-26}
  s.description = %q{A gem to provide swappable JSON backends utilizing Yajl::Ruby, the JSON gem, ActiveSupport, or JSON pure.}
  s.email = ["michael@intridea.com"]
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = [".document", ".gitignore", ".rspec", ".travis.yml", "Gemfile", "LICENSE", "README.rdoc", "Rakefile", "lib/multi_json.rb", "lib/multi_json/engines/json_gem.rb", "lib/multi_json/engines/json_pure.rb", "lib/multi_json/engines/ok_json.rb", "lib/multi_json/engines/yajl.rb", "lib/multi_json/vendor/ok_json.rb", "lib/multi_json/version.rb", "multi_json.gemspec", "spec/multi_json_spec.rb", "spec/spec.opts", "spec/spec_helper.rb"]
  s.homepage = %q{http://github.com/intridea/multi_json}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A gem to provide swappable JSON backends.}
  s.test_files = ["spec/multi_json_spec.rb", "spec/spec.opts", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
