module Rottendesk
  class Client

    def initialize(url)
      @rest_client = RestClient::Resource.new(url)
    end

    def get(url, options = {})
      request(url, options.merge(method: :get))
    end

    def post(url, body,  options = {})
      request(url, options.merge(method: :post, body: body))
    end

    def patch(url, body, options = {})
      request(url, options.merge(method: :patch, body: body))
    end

    def delete(url, options = {})
      request(url, options.merge(method: :delete))
    end

    def request(url, options = {})
      defaults = {
        method: :get,
        content_type: :json,
        accept: :json,
        append_json: true
      }
      options = defaults.merge(options)

      url += '.json' if options[:append_json]

      Rottendesk.logger.info "Rottendesk: #{options[:method].upcase} /#{url} with #{options.except(:method)}"

      args = [options[:method], options[:body], options.except(:method, :body)].compact
      response = @rest_client[url].send(*args)

      Rottendesk.logger.info "Rottendesk: #{response.code}"

      response

    rescue RestClient::Exception => e
      Rottendesk.logger.warn "Rottendesk: #{e.response.code}"
      raise e
    end
  end
end
