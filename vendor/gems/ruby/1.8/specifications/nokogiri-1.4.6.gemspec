# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{nokogiri}
  s.version = "1.4.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Aaron Patterson}, %q{Mike Dalessio}]
  s.date = %q{2011-06-19}
  s.description = %q{Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser.  Among Nokogiri's
many features is the ability to search documents via XPath or CSS3 selectors.

XML is like violence - if it doesn’t solve your problems, you are not using
enough of it.}
  s.email = [%q{aaronp@rubyforge.org}, %q{mike.dalessio@gmail.com}]
  s.executables = [%q{nokogiri}]
  s.extensions = [%q{ext/nokogiri/extconf.rb}]
  s.extra_rdoc_files = [%q{Manifest.txt}, %q{README.ja.rdoc}, %q{CHANGELOG.rdoc}, %q{CHANGELOG.ja.rdoc}, %q{README.rdoc}, %q{ext/nokogiri/xml_sax_push_parser.c}, %q{ext/nokogiri/xml_relax_ng.c}, %q{ext/nokogiri/html_sax_parser_context.c}, %q{ext/nokogiri/html_entity_lookup.c}, %q{ext/nokogiri/xml_text.c}, %q{ext/nokogiri/nokogiri.c}, %q{ext/nokogiri/xml_element_decl.c}, %q{ext/nokogiri/xml_encoding_handler.c}, %q{ext/nokogiri/html_document.c}, %q{ext/nokogiri/xslt_stylesheet.c}, %q{ext/nokogiri/xml_attribute_decl.c}, %q{ext/nokogiri/xml_io.c}, %q{ext/nokogiri/xml_document_fragment.c}, %q{ext/nokogiri/xml_namespace.c}, %q{ext/nokogiri/xml_libxml2_hacks.c}, %q{ext/nokogiri/xml_sax_parser_context.c}, %q{ext/nokogiri/xml_comment.c}, %q{ext/nokogiri/xml_sax_parser.c}, %q{ext/nokogiri/html_element_description.c}, %q{ext/nokogiri/xml_xpath_context.c}, %q{ext/nokogiri/xml_syntax_error.c}, %q{ext/nokogiri/xml_document.c}, %q{ext/nokogiri/xml_entity_decl.c}, %q{ext/nokogiri/xml_node.c}, %q{ext/nokogiri/xml_node_set.c}, %q{ext/nokogiri/xml_reader.c}, %q{ext/nokogiri/xml_processing_instruction.c}, %q{ext/nokogiri/xml_element_content.c}, %q{ext/nokogiri/xml_dtd.c}, %q{ext/nokogiri/xml_attr.c}, %q{ext/nokogiri/xml_schema.c}, %q{ext/nokogiri/xml_cdata.c}, %q{ext/nokogiri/xml_entity_reference.c}]
  s.files = [%q{bin/nokogiri}, %q{Manifest.txt}, %q{README.ja.rdoc}, %q{CHANGELOG.rdoc}, %q{CHANGELOG.ja.rdoc}, %q{README.rdoc}, %q{ext/nokogiri/xml_sax_push_parser.c}, %q{ext/nokogiri/xml_relax_ng.c}, %q{ext/nokogiri/html_sax_parser_context.c}, %q{ext/nokogiri/html_entity_lookup.c}, %q{ext/nokogiri/xml_text.c}, %q{ext/nokogiri/nokogiri.c}, %q{ext/nokogiri/xml_element_decl.c}, %q{ext/nokogiri/xml_encoding_handler.c}, %q{ext/nokogiri/html_document.c}, %q{ext/nokogiri/xslt_stylesheet.c}, %q{ext/nokogiri/xml_attribute_decl.c}, %q{ext/nokogiri/xml_io.c}, %q{ext/nokogiri/xml_document_fragment.c}, %q{ext/nokogiri/xml_namespace.c}, %q{ext/nokogiri/xml_libxml2_hacks.c}, %q{ext/nokogiri/xml_sax_parser_context.c}, %q{ext/nokogiri/xml_comment.c}, %q{ext/nokogiri/xml_sax_parser.c}, %q{ext/nokogiri/html_element_description.c}, %q{ext/nokogiri/xml_xpath_context.c}, %q{ext/nokogiri/xml_syntax_error.c}, %q{ext/nokogiri/xml_document.c}, %q{ext/nokogiri/xml_entity_decl.c}, %q{ext/nokogiri/xml_node.c}, %q{ext/nokogiri/xml_node_set.c}, %q{ext/nokogiri/xml_reader.c}, %q{ext/nokogiri/xml_processing_instruction.c}, %q{ext/nokogiri/xml_element_content.c}, %q{ext/nokogiri/xml_dtd.c}, %q{ext/nokogiri/xml_attr.c}, %q{ext/nokogiri/xml_schema.c}, %q{ext/nokogiri/xml_cdata.c}, %q{ext/nokogiri/xml_entity_reference.c}, %q{ext/nokogiri/extconf.rb}]
  s.homepage = %q{http://nokogiri.org}
  s.rdoc_options = [%q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{nokogiri}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<racc>, [">= 0"])
      s.add_development_dependency(%q<rexical>, [">= 0"])
      s.add_development_dependency(%q<rake-compiler>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 1.6.0"])
      s.add_development_dependency(%q<hoe>, [">= 2.9.4"])
    else
      s.add_dependency(%q<racc>, [">= 0"])
      s.add_dependency(%q<rexical>, [">= 0"])
      s.add_dependency(%q<rake-compiler>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 1.6.0"])
      s.add_dependency(%q<hoe>, [">= 2.9.4"])
    end
  else
    s.add_dependency(%q<racc>, [">= 0"])
    s.add_dependency(%q<rexical>, [">= 0"])
    s.add_dependency(%q<rake-compiler>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 1.6.0"])
    s.add_dependency(%q<hoe>, [">= 2.9.4"])
  end
end
