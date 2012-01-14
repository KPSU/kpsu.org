# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby-openid}
  s.version = "2.1.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{JanRain, Inc}]
  s.autorequire = %q{openid}
  s.date = %q{2010-07-22}
  s.email = %q{openid@janrain.com}
  s.extra_rdoc_files = [%q{README}, %q{INSTALL}, %q{LICENSE}, %q{UPGRADE}]
  s.files = [%q{README}, %q{INSTALL}, %q{LICENSE}, %q{UPGRADE}]
  s.homepage = %q{http://github.com/openid/ruby-openid}
  s.rdoc_options = [%q{--main}, %q{README}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{A library for consuming and serving OpenID identities.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
