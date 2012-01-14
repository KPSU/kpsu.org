require "searchlogic/core_ext/proc"
require "searchlogic/core_ext/object"
require "searchlogic/active_record/association_proxy"
require "searchlogic/active_record/consistency"
require "searchlogic/active_record/named_scope_tools"
require "searchlogic/named_scopes/conditions"
require "searchlogic/named_scopes/ordering"
require "searchlogic/named_scopes/association_conditions"
require "searchlogic/named_scopes/association_ordering"
require "searchlogic/named_scopes/alias_scope"
require "searchlogic/named_scopes/or_conditions"
require "searchlogic/search"

ActiveRecord::Relation.send(:include, Searchlogic::CoreExt::Proc)
Proc.send(:include, Searchlogic::CoreExt::Proc)
Object.send(:include, Searchlogic::CoreExt::Object)

module ActiveRecord # :nodoc: all
  module Associations
    class AssociationProxy
      include Searchlogic::ActiveRecord::AssociationProxy
    end
  end

# FIX: removed this to get tests running
#  class Base
#    class << self; include Searchlogic::ActiveRecord::Consistency; end
#  end
end

m = Searchlogic::NamedScopes
[
  Searchlogic::ActiveRecord::NamedScopeTools,
  m::Conditions,
  m::AssociationConditions,
  m::AssociationOrdering,
  m::Ordering,
#  m::AliasScope
#  m::OrConditions
].each do |_module|
  ActiveRecord::Base.extend(_module)
  ActiveRecord::Relation.send(:include, _module)
end
#ActiveRecord::Base.extend(Searchlogic::ActiveRecord::NamedScopeTools)
#ActiveRecord::Base.extend(Searchlogic::NamedScopes::Conditions)

#ActiveRecord::Base.extend(Searchlogic::NamedScopes::AssociationConditions)
#ActiveRecord::Base.extend(Searchlogic::NamedScopes::AssociationOrdering)
#ActiveRecord::Base.extend(Searchlogic::NamedScopes::Ordering)
#ActiveRecord::Base.extend(Searchlogic::NamedScopes::AliasScope)
#ActiveRecord::Base.extend(Searchlogic::NamedScopes::OrConditions)
ActiveRecord::Base.extend(Searchlogic::Search::Implementation)


# Try to use the search method, if it's available. Thinking sphinx and other plugins
# like to use that method as well.
if !ActiveRecord::Base.respond_to?(:search)
  ActiveRecord::Base.class_eval { class << self; alias_method :search, :searchlogic; end }
end

if defined?(ActionController)
  require "searchlogic/rails_helpers"
  ActionController::Base.helper(Searchlogic::RailsHelpers)
end

#FIX: for bug in active_record 3.0.0.beta3 -- left over from Rails 2.3.x, and wasn't removed from attribute_condition method in ActiveRecord::Base
module ActiveRecord
  module NamedScope
    class Scope; end
  end
end

#FIX: proxy_options is used extensively throughout SL testing to determine that no conditions, ordering, etc. were set
#module ActiveRecord
#  class Relation
#    def proxy_options
#      [:where_clauses, :order_clauses].inject({}) do |hash, method|
#        clauses = send(method)
#        unless clauses.empty?
#          case method
#          when :where_clauses then hash[:conditions] = clauses
#          when :order_clauses then hash[:order] = clauses
#          end
#        end
#        hash
#      end
#    end
#  end
#end