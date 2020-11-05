module Porygon
  class CommandDetector
    def self.detect(message)
      new(message).detect
    end

    attr_reader :message, :content
    delegate :prefix, to: :Bot

    def initialize(message)
      @message = message
      @content = message.content.dup
    end
    
    def detect
      return unless content.slice!(0...prefix.size) == prefix
      transform_content

      tag  = content.split(/\s+/).first.downcase
      args = content[tag.size..].strip

      unless (command = Commands::TAGS[tag])
        log_missing(tag)
        return
      end 

      command.new(message, tag, args)
    end

    private
    
    def log_missing(tag)
      Commands::CommandLogger.unknown_command(tag, message)
    end

    def transform_content
      transform_remove_whitespace
      transform_em_dash_to_flags
      transform_setter_calls
    end

    def transform_remove_whitespace
      content.strip!
    end

    def transform_em_dash_to_flags
      content.gsub!('—', '--')
    end

    def transform_setter_calls
      content.gsub!(/^([A-z0-9]+)\s*=\s*/, 'set\1 ')
    end
  end
end