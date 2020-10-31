module Porygon
  class CommandDetector
    def self.detect(message)
      new(message).detect
    end

    attr_reader :message
    delegate :content, to: :message

    def initialize(message)
      @message = message
    end
    
    def detect
      return unless content.start_with? Bot.prefix

      tag  = content[1..].split(/\s+/).first.downcase
      args = content[(Bot.prefix.length + tag.length)..].strip

      return unless (command = Commands::TAGS[tag])

      command.new(message, tag, args)
    end
  end
end