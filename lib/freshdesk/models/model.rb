require 'rest_client'
require 'json'

module Freshdesk
  class Model
    class << self

      attr_accessor :app

      def find(id)
        parse(app.client["#{@endpoint}/#{id}.json"].get)
      end

      def search(filters = {})
        parse(app.client["#{@endpoint}.json"].get params: filters)
      end

      def parse(json)
        remote_fields = JSON.parse(json)

        if remote_fields.is_a? Array
          remote_fields.map{|f| parse_resource(f)}
        else
          parse_resource(remote_fields)
        end
      end

      def parse_resource(resource)
        model = self.new

        resource = resource[@json_key]

        @_fields.each do |f|
          model.send("#{f}=", resource[f.to_s]) if model.respond_to? "#{f}="
        end
        model
      end

      def field(field)
        @_fields ||= []
        @_fields << field

        attr_accessor field
      end

      def endpoint(endpoint)
        @endpoint ||= endpoint
      end

      def json_key(key)
        @json_key = key
      end

    end
  end
end
