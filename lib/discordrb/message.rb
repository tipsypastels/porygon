module Discordrb
  class Message
    def command
      @command ||= Porygon::CommandDetector.detect(self)
    end
  end
end