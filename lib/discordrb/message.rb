module Discordrb
  class Message
    delegate :server,   to: :channel
    delegate :username, to: :author
    delegate :name,     to: :channel, prefix: true
    delegate :name,     to: :server,  prefix: true

    def run_used_command
      command&.begin_call
    end

    private

    def command
      Porygon::CommandDetector.detect(self)
    end
  end
end