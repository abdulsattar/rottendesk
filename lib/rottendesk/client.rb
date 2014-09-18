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

    def put(url, body, options = {})
      request(url, options.merge(method: :put, body: body))
    end

    def delete(url, options = {})
      request(url, options.merge(method: :delete))
    end

    def request(url, options = {})
      options, params = split_options(options)

      url += '.json' if options[:append_json]

      Rottendesk.logger.info "#{options[:method].upcase} /#{url} with #{params}"

      args = [options[:method], options[:body], params].compact
      response = @rest_client[url].send(*args)

      Rottendesk.logger.info response.code

      response
    rescue RestClient::Exception => e
      Rottendesk.logger.warn e.response.code
      raise e
    end

    private
    # Split options into request options and params
    def split_options(options = {})
      defaults = {
        method: :get,
        content_type: :json,
        accept: :json,
        append_json: true
      }
      options = defaults.merge(options)
      request_options = [:body, :method, :append_json]
      [options.only(*request_options), options.except(*request_options)]
    end
  end
end
