# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails3-jquery-autocomplete}
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Padilla"]
  s.date = %q{2010-12-05}
  s.description = %q{Use jQuery's autocomplete plugin with Rails 3.}
  s.email = %q{david.padilla@crowdint.com}
  s.extra_rdoc_files = ["LICENSE", "README.markdown"]
  s.files = ["README.markdown", "Rakefile", "lib/cucumber/autocomplete.rb", "lib/generators/autocomplete_generator.rb", "lib/generators/templates/autocomplete-rails.js", "lib/rails3-jquery-autocomplete.rb", "lib/rails3-jquery-autocomplete/autocomplete.rb", "lib/rails3-jquery-autocomplete/form_helper.rb", "lib/rails3-jquery-autocomplete/formtastic_plugin.rb", "lib/rails3-jquery-autocomplete/helpers.rb", "test/form_helper_test.rb", "test/generators/generator_test.rb", "test/helpers.rb", "test/implementations_test.rb", "test/support/active_record.rb", "test/support/mongoid.rb", "test/test_controller.rb", "test/test_helper.rb", "LICENSE"]
  s.homepage = %q{http://github.com/crowdint/rails3-jquery-autocomplete}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Use jQuery's autocomplete plugin with Rails 3.}
  s.test_files = ["test/form_helper_test.rb", "test/generators/generator_test.rb", "test/helpers.rb", "test/implementations_test.rb", "test/support/active_record.rb", "test/support/mongoid.rb", "test/test_controller.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rails>, [">= 3.0.0"])
    else
      s.add_dependency(%q<rails>, [">= 3.0.0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0.0"])
  end
end
