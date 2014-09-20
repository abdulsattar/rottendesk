require "rottendesk/version"

require 'pry'

require 'rottendesk/helpers/class'
require 'rottendesk/helpers/hash'

require 'rottendesk/fields/field'
require 'rottendesk/fields/date_field'
require 'rottendesk/fields/association_field'
require 'rottendesk/fields/enum_field'

require 'rottendesk/models/dirty'
require 'rottendesk/models/model'
require 'rottendesk/models/ticket'
require 'rottendesk/models/user'
require 'rottendesk/models/customer'

require 'rottendesk/client'
require 'rottendesk/app'

module Rottendesk
  class << self
    attr_reader :logger

    def logger=(logger)
      @logger = logger
      @logger.formatter = proc do |severity, datetime, progname, msg|
        "Rottendesk #{severity}: #{msg}\n"
      end
    end
  end
end

Rottendesk.logger = Logger.new $stdout
