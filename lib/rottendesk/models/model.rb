require 'rest_client'
require 'json'

module Rottendesk
  class Model

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
    end

    def update
    end

    def to_h
      fields.reduce({}){|h, f| h[f] = self.send(f); h}.compact
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
      fields.each do |f|
        self.instance_variable_set("@#{f}", json[f.to_s])
      end
      self
    end

    def fields
      self.class.fields
    end

    protected
    def create_new
      json = {json_key => to_h}.to_json
      response = client.post(endpoint, json)
      self.from_json response
    rescue RestClient::UnprocessableEntity => ex
      @errors = Hash[JSON.parse(ex.response)]
      self
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

      def field(field, options = {})
        @_fields ||= []
        @_fields << field

        attr_reader field
        attr_writer field unless options[:readonly]
      end

      def fields
        @_fields
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
