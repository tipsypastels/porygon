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
      args = transform_args(args)

      return unless (command = Commands::TAGS[tag])

      command.new(message, tag, args)
    end

    private

    def transform_args(args)
      transform_em_dash_to_flags(args)
    end

    def transform_em_dash_to_flags(args)
      args.gsub('—', '--')
    end
  end
end