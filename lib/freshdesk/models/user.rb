module Freshdesk
  class User < Model
    class << self
      attr_accessor :app
    end
  end
end
