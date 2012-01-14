module Searchlogic
  module NamedScopes
    # Handles dynamically creating named scopes for ordering by columns. Example:
    #
    #   User.ascend_by_id
    #   User.descend_by_username
    #
    # See the README for a more detailed explanation.
    module Ordering
      def condition?(name) # :nodoc:
        super || ordering_condition?(name)
      end

      def self.included(base)
        #this overrides the 'new' method in any class including Ordering -- then when called, new overrides the 'order' method
        #overriding is not a simple matter in Ruby because includes put the modules below the class in the superclass sequence
        #this keeps the code cleaner by avoiding alias_method_chain (monkey patching)
        (class << base; self; end).send(:include, ClassOverrideMethods)
      end

      module ClassOverrideMethods
        def new(*args)
          _inst = super
          #this overrides the 'order' method
          (class << _inst; self; end).send(:include, Searchlogic::NamedScopes::Ordering::InstanceOverrideMethods)
          _inst
        end
      end
      module InstanceOverrideMethods
        def order(*args)
          if condition?(args[0])
            send(args[0])
          else
            super
          end
        end
      end
      
      private
        def ordering_condition?(name) # :nodoc:
          !ordering_condition_details(name).nil?
        end
        
        def method_missing(name, *args, &block)
          if name == :order
            scope name, lambda { |scope_name|
              return {} if !condition?(scope_name)
              send(scope_name).proxy_options
            }
            send(name, *args)
          end
          if details = ordering_condition_details(name)
            create_ordering_conditions(details[:column])
            send(name, *args)
          else
            super
          end
        end
        
        def ordering_condition_details(name)
          if name.to_s =~ /^(ascend|descend)_by_(#{column_names.join("|")})$/
            {:order_as => $1, :column => $2}
          elsif name.to_s =~ /^order$/
            {}
          end
        end
        
        def create_ordering_conditions(column)
          scope("ascend_by_#{column}".to_sym, {:order => "#{table_name}.#{column} ASC"})
          scope("descend_by_#{column}".to_sym, {:order => "#{table_name}.#{column} DESC"})
        end
    end
  end
end
