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

      transform_content(@content)
    end
    
    def detect
      return unless content.start_with? Bot.prefix

      tag  = content[prefix.size..].split(/\s+/).first.downcase
      args = content[(prefix.size + tag.length)..].strip

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

    def transform_content(content)
      transform_em_dash_to_flags(content)
      transform_setter_calls(content)
    end

    def transform_setter_calls(content)
      content.gsub!(/^#{prefix}([A-z0-9]+)\s*=\s*/, prefix + 'set\1 ')
    end

    def transform_em_dash_to_flags(content)
      content.gsub!('—', '--')
    end
  end
end