module Rottendesk
  class DateField < Field
    def from_json(json)
      value = json[freshdesk_name.to_s]
      value = Time.parse(value) unless value.nil?
      [name, value]
    end

    def to_json(hash)
      value = hash[freshdesk_name]
      value = value.iso8601 unless value.nil?
      [name, value]
    end
  end
end
