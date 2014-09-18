require 'rest_client'
require 'json'

module Rottendesk
  class Model

    include Rottendesk::Dirty

    def initialize(attrs = {})
      attrs.each do |k,v|
        self.send("#{k}=", v) if respond_to? "#{k}="
      end
    end

    def persisted?
      !self.id.nil?
    end

    def save
      persisted? ? update : create_new
      changes_applied
      self
    end

    def to_h
      field_names.reduce({}){|h, f| h[f] = self.send(f); h}.compact
    end

    def to_json(*only_fields)
      only_fields = fields if only_fields.empty?
      hash = to_h.only(*self.class.writable_fields)
      json = fields.reduce({}) do |result,f|
        _, field = f
        result.merge(field.to_json(hash))
      end
      {json_key => json}.to_json
    end

    def errors
      @errors
    end

    def valid?
      errors.nil? || errors.empty?
    end

    def from_json(json)
      json = JSON.parse(json) if json.is_a? String
      json = json[json_key] if json[json_key]
      fields.each do |name, f|
        name,value = f.from_json(json)
        instance_variable_set("@#{name}", value)
      end
      self
    end

    def fields
      self.class.fields
    end

    def field_names
      fields.keys
    end

    protected

    def update
      json = to_json(*changed_fields.keys)
      client.put("#{endpoint}/#{id}", json)
    rescue RestClient::UnprocessableEntity => ex
      @errors = Hash[JSON.parse(ex.response)]
    end

    def create_new
      response = client.post(endpoint, to_json)
      self.from_json response
    rescue RestClient::UnprocessableEntity => ex
      @errors = Hash[JSON.parse(ex.response)]
    end

    def endpoint
      self.class.get_endpoint
    end

    def json_key
      self.class.get_json_key
    end

    def client
      self.class.app.client
    end

    class << self

      attr_accessor :app

      def create(attrs = {})
        model = self.new(attrs)
        model.save
      end

      def find(id)
        parse(app.client.get("#{@endpoint}/#{id}"))
      end

      def where(filters = {})
        parse(app.client.get(@endpoint, params: filters))
      end

      def parse(json)
        remote_fields = JSON.parse(json)

        if remote_fields.is_a? Array
          remote_fields.map{|f| self.new.from_json(f)}
        else
          self.new.from_json(remote_fields)
        end
      end

      def field(name, options = {})
        @_fields ||= {}

        type = Rottendesk.const_get((options[:type].to_s || '').capitalize + 'Field')
        field = @_fields[name] = type.new(name, options)
        field.define_accessors(self)
      end

      def fields
        @_fields
      end

      def writable_fields
        fields.map{|name, f| name unless f.readonly?}.compact
      end

      def endpoint(endpoint)
        @endpoint ||= endpoint
      end

      def json_key(key)
        @json_key = key
      end

      def get_endpoint
        @endpoint
      end

      def get_json_key
        @json_key
      end
    end
  end
end
