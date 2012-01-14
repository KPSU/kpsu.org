module Searchlogic
  module NamedScopes
    # Handles dynamically creating named scopes for associations. See the README for a detailed explanation.
    module AssociationConditions
      def condition?(name) # :nodoc:
        super || association_condition?(name)
      end

      def _resolve_deep_association_conditions(condition_name, args)
        if local_condition?(condition_name)
          {:joins=>nil, :klass=>self, :condition=>condition_name}
        elsif details = association_condition_details(condition_name)
          result = details[:association].klass._resolve_deep_association_conditions(details[:condition], args)
          return nil unless result #condition method did not resolve
          this_association = details[:association].name
          join_condition = result[:joins].nil? ? this_association : {this_association=>result[:joins]}
          result.merge(:joins=>join_condition)
        else #this condition method did not resolve
          nil
        end
      end


      
      private
        def association_condition?(name)
          !association_condition_details(name).nil? unless name.to_s.downcase.match("_or_")
        end
        
        def method_missing(name, *args, &block)
          if !local_condition?(name) && details = association_condition_details(name)
            create_scope_for_association(details[:association], details[:condition], args, details[:poly_class])
            send(name, *args)
          else
            super
          end
        end

        def create_scope_for_association(association, condition_name, args, poly_class = nil)
          result = (poly_class || association.klass)._resolve_deep_association_conditions(condition_name, args)
          return unless result

          joins_result = result[:joins].nil? ? association.name : {association.name => result[:joins]}

          lambda_containing_relational_algebra = eval <<-"end_eval"
            lambda { |*args|
              #{result[:klass].name}.#{result[:condition]}(*args).joins(#{joins_result.inspect})
            }
          end_eval

          name = [association.name, poly_class && "#{poly_class.name.underscore}_type", condition_name].compact.join("_")
          scope(name, lambda_containing_relational_algebra)
        end

        def association_condition_details(name, last_condition = nil)
          non_poly_assocs = reflect_on_all_associations.reject { |assoc| assoc.options[:polymorphic] }.sort { |a, b| b.name.to_s.size <=> a.name.to_s.size }
          poly_assocs = reflect_on_all_associations.reject { |assoc| !assoc.options[:polymorphic] }.sort { |a, b| b.name.to_s.size <=> a.name.to_s.size }
          return nil if non_poly_assocs.empty? && poly_assocs.empty?
        
          name_with_condition = [name, last_condition].compact.join('_')
          
          association_name = nil
          poly_type = nil
          condition = nil
          
          if name_with_condition.to_s =~ /^(#{non_poly_assocs.collect(&:name).join("|")})_(\w+)$/
            association_name = $1
            condition = $2
          elsif name_with_condition.to_s =~ /^(#{poly_assocs.collect(&:name).join("|")})_(\w+?)_type_(\w+)$/
            association_name = $1
            poly_type = $2
            condition = $3
          end
          
          if association_name && condition
            association = reflect_on_association(association_name.to_sym)
            klass = poly_type ? poly_type.camelcase.constantize : association.klass
            if klass.condition?(condition)
              {:association => association, :poly_class => poly_type && klass, :condition => condition}
            else
              nil
            end
          end
        end
        
        
#        def association_condition_options(association, association_condition, args, poly_class = nil)
#          klass = poly_class ? poly_class : association.klass
#          relation = klass.send(association_condition, *args)
#          scope_options = nil #klass.named_scope_options(association_condition)
#          arity = -1 #klass.named_scope_arity(association_condition)
#
#          if !arity || arity == 0
#            # The underlying condition doesn't require any parameters, so let's just create a simple
#            # named scope that is based on a hash.
#            options = {}
#            in_searchlogic_delegation { options = relation.scope(:find) }
#            prepare_named_scope_options(options, association, poly_class)
#            options
#          else
#            proc_args = arity_args(arity)
#            arg_type = :string #(scope_options.respond_to?(:searchlogic_options) && scope_options.searchlogic_options[:type]) || :string
#
#            eval <<-"end_eval"
#              searchlogic_lambda(:#{arg_type}) { |#{proc_args.join(",")}|
#                options = {}
#
#                in_searchlogic_delegation do
#                  relation = klass.send(association_condition, #{proc_args.join(",")})
#                  options = {:conditions=>"users.username LIKE '%joe%'"} #relation.scope(:find) if relation
#                end
#
#                prepare_named_scope_options(options, association, poly_class)
#                options
#              }
#            end_eval
#          end
#        end
        
        # Used to match the new scopes parameters to the underlying scope. This way we can disguise the
        # new scope as best as possible instead of taking the easy way out and using *args.
#        def arity_args(arity)
#          args = []
#          if arity > 0
#            arity.times { |i| args << "arg#{i}" }
#          else
#            positive_arity = arity * -1
#            positive_arity.times do |i|
#              if i == (positive_arity - 1)
#                args << "*arg#{i}"
#              else
#                args << "arg#{i}"
#              end
#            end
#          end
#          args
#        end

#        #ADDED: this was removed from AR::Base ver2.x, redefined for use in prepare_named_scope_options
#        def array_of_strings?(o)
#          o.is_a?(Array) && o.all?{|obj| obj.is_a?(String)}
#        end
#
#        def prepare_named_scope_options(options, association, poly_class = nil)
#          options.delete(:readonly) # AR likes to set :readonly to true when using the :joins option, we don't want that
#
#          klass = poly_class || association.klass
#          # sanitize the conditions locally so we get the right table name, otherwise the conditions will be evaluated on the original model
#          options[:conditions] = klass.sanitize_sql_for_conditions(options[:conditions]) if options[:conditions].is_a?(Hash)
#
#          poly_join = poly_class && inner_polymorphic_join(poly_class.name.underscore, :as => association.name)
#
#          if options[:joins].is_a?(String) || array_of_strings?(options[:joins])
#            options[:joins] = [poly_class ? poly_join : inner_joins(association.name), options[:joins]].flatten
#          elsif poly_class
#            options[:joins] = options[:joins].blank? ? poly_join : ([poly_join] + klass.inner_joins(options[:joins]))
#          else
#            options[:joins] = options[:joins].blank? ? association.name : {association.name => options[:joins]}
#          end
#        end
    end
  end
end
