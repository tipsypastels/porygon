module Discordrb
  class Message
    delegate :server,   to: :channel
    delegate :username, to: :author
    delegate :name,     to: :channel, prefix: true
    delegate :name,     to: :server,  prefix: true

    def command
      @command ||= Porygon::CommandDetector.detect(self)
    end
  end
end