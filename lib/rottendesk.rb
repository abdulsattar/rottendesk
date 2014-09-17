require "rottendesk/version"

require 'rottendesk/helpers/class'
require 'rottendesk/helpers/hash'

require 'rottendesk/models/dirty'
require 'rottendesk/models/model'
require 'rottendesk/models/ticket'
require 'rottendesk/models/user'

require 'rottendesk/client'
require 'rottendesk/app'

module Rottendesk
  class << self
    attr_accessor :logger
  end
end

Rottendesk.logger = Logger.new $stdout
