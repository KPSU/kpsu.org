# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby-aaws}
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ian Macdonald"]
  s.date = %q{2009-06-15}
  s.email = %q{ian@caliban.org}
  s.extra_rdoc_files = ["COPYING", "INSTALL", "NEWS", "README", "README.rdoc"]
  s.files = ["example/customer_content_lookup1", "example/browse_node_lookup1", "example/item_lookup1", "example/example1", "example/customer_content_search1", "example/help1", "example/multiple_operation1", "example/item_lookup2", "example/item_search1", "example/item_search2", "example/item_search3", "example/list_lookup1", "example/list_search1", "example/vehicle_search", "example/seller_listing_lookup1", "example/seller_listing_search1", "example/seller_lookup1", "example/shopping_cart1", "example/similarity_lookup1", "example/tag_lookup1", "example/transaction_lookup1", "example/batch_operation", "lib/amazon.rb", "lib/amazon/aws/search.rb", "lib/amazon/aws/cache.rb", "lib/amazon/aws/shoppingcart.rb", "lib/amazon/locale.rb", "lib/amazon/aws.rb", "test/tc_amazon.rb", "test/setup.rb", "test/tc_item_search.rb", "test/tc_aws.rb", "test/tc_multiple_operation.rb", "test/tc_help.rb", "test/tc_operation_request.rb", "test/tc_shopping_cart.rb", "test/ts_aws.rb", "test/tc_serialisation.rb", "test/tc_vehicle_operations.rb", "test/tc_item_lookup.rb", "test/tc_seller_listing_search.rb", "test/tc_browse_node_lookup.rb", "test/tc_customer_content_lookup.rb", "test/tc_list_lookup.rb", "test/tc_list_search.rb", "test/tc_seller_listing_lookup.rb", "test/tc_seller_lookup.rb", "test/tc_similarity_lookup.rb", "test/tc_tag_lookup.rb", "test/tc_transaction_lookup.rb", "COPYING", "INSTALL", "NEWS", "README", "README.rdoc"]
  s.homepage = %q{http://www.caliban.org/ruby/ruby-aws/}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = %q{Ruby/(A)AWS}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby interface to Amazon Associates Web Services}
  s.test_files = ["test/tc_amazon.rb", "test/setup.rb", "test/tc_item_search.rb", "test/tc_aws.rb", "test/tc_multiple_operation.rb", "test/tc_help.rb", "test/tc_operation_request.rb", "test/tc_shopping_cart.rb", "test/ts_aws.rb", "test/tc_serialisation.rb", "test/tc_vehicle_operations.rb", "test/tc_item_lookup.rb", "test/tc_seller_listing_search.rb", "test/tc_browse_node_lookup.rb", "test/tc_customer_content_lookup.rb", "test/tc_list_lookup.rb", "test/tc_list_search.rb", "test/tc_seller_listing_lookup.rb", "test/tc_seller_lookup.rb", "test/tc_similarity_lookup.rb", "test/tc_tag_lookup.rb", "test/tc_transaction_lookup.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
