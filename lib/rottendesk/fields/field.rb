module Rottendesk
  class Field
    attr_reader :name, :freshdesk_name

    def initialize(name, options = {})
      options = {freshdesk_name: name, readonly: false}.merge(options)

      @name = name
      @freshdesk_name = options[:freshdesk_name]
      @readonly = options[:readonly]
    end

    def readonly?
      @readonly
    end

    # TODO: Think of better integration between Rottendesk::Dirty and this
    # method
    def define_accessors(klass)
      klass.instance_eval <<-ATTR
        attr_reader :#{name}

        define_dirty_methods(:#{name}) if respond_to? :define_dirty_methods
      ATTR

      if !readonly?
        klass.class_eval %Q{
          def #{name}=(value)
            #{name}_changed! if (respond_to? :#{name}_changed!) && @#{name} != value
            @#{name} = value
          end
        }
      end
    end

    def from_json(json)
      [name, json[freshdesk_name.to_s]]
    end

    def to_json(hash)
      {freshdesk_name => hash[name]}
    end
  end
end
