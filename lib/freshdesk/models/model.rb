require 'rest_client'

module Freshdesk
  class Model
    class << self

      def rest
        app.resource
      end

      def find(id)
        rest["#{id}.json"].get
      end
    end
  end
end
