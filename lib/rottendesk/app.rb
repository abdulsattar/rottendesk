require 'logger'

module Rottendesk
  class App
    attr_accessor :url, :username, :password, :ssl

    def initialize(url, username, password = 'X', ssl = false)
      @url = url
      @username = username
      @password = password
      @ssl = ssl
    end

    def client
      @client ||= Client.new("http#{ssl ? '' : 's'}://#{username}:#{password}@#{url}")
    end


    models = [User, Ticket, Customer]

    models.each do |m|
      class_eval %Q<
        def #{m.short_name}
          @#{m.short_name.downcase} ||= begin
                                          #{m}.app = self
                                          #{m}
                                        end
        end
      >
    end
  end
end
