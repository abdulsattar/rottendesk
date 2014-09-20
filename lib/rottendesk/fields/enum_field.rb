module Rottendesk
  class EnumField < Field
    def initialize(name, options = {})
      super
      @symbols = options[:symbols] || {}
    end

    def from_json(json)
      [name, @symbols.invert[json[freshdesk_name.to_s]]]
    end

    def to_json(hash)
      {freshdesk_name => @symbols[hash[name]]}
    end
  end
end
