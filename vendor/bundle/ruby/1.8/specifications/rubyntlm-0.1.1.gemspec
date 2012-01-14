# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rubyntlm}
  s.version = "0.1.1"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Kohei Kajimoto}]
  s.autorequire = %q{net/ntlm}
  s.cert_chain = nil
  s.date = %q{2006-10-04}
  s.description = %q{Ruby/NTLM provides message creator and parser for the NTLM authentication.}
  s.email = %q{koheik@gmail.com}
  s.extra_rdoc_files = [%q{README}]
  s.files = [%q{README}]
  s.homepage = %q{http://rubyforge.org/projects/rubyntlm}
  s.rdoc_options = [%q{--main}, %q{README}]
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = %q{rubyntlm}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Ruby/NTLM library.}

  if s.respond_to? :specification_version then
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
