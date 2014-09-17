module Rottendesk
  module Dirty
    def self.included(base)
      base.extend ClassMethods
    end

    attr_reader :previous_changes

    def changed_fields
      @changed_fields ||= {}
    end

    module ClassMethods
      def field_accessor(field, options = {})
        attr_reader field

        define_dirty_methods(field)

        if !options[:readonly]
          class_eval %Q{
            def #{field}=(value)
              #{field}_changed! if @#{field} != value
              @#{field} = value
            end
          }
        end
      end

      def define_dirty_methods(field)
        define_method "#{field}_changed!" do
          changed_fields[field] = __send__(field)
        end

        define_method "#{field}_changed?" do
          changed_fields.key?(field)
        end

        define_method "changes_applied" do
          @previous_changes = changed_fields
          @changed_fields = {}
        end
      end
    end
  end
end
