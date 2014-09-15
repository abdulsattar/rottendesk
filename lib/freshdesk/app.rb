require 'logger'

module Freshdesk
  class App
    attr_accessor :url, :username, :password, :ssl

    def initialize(url, username, password = 'X', ssl = false)
      @url = url
      @username = username
      @password = password
      @ssl = true
    end

    def resource
      RestClient.log = Logger.new($stdout)
      @resource ||= RestClient::Resource.new("http#{ssl ? '' : 's'}://#{username}:#{password}@#{url}")
    end

    def User
      @user ||= begin
                  Freshdesk::User.app = self
                  Freshdesk::User
                end
    end
  end
end
