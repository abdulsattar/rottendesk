module Rottendesk
  class AssociationField < Field
    def initialize(name, options = {})
      super
      @object_name = name.to_s.gsub(/_id$/, '')
      @object_class_name = options[:class] || @object_name.capitalize
    end
    def define_accessors(klass)
      super
      klass.class_eval <<-ATTR
        def #{@object_name}
          @#{@object_name} ||= (self.class.app.send(@object_class_name).find(#{name}) if #{name})
        end

        def #{@object_name}=(value)
          self.#{name} = value.id
          @#{@object_name} = value
        end
      ATTR
    end
  end
end
