module EventLogging
  class EventLogger
    include Porygon::MessageFormatter

    def self.log(...)
      new(...).log
    end

    attr_reader :server

    def initialize(server)
      @server = server
    end

    private

    def embed(message = nil, warning: false, &block)
      embed = Porygon::EmbedBuilder.build(&block)
      
      embed_to_channel(mod_channel, message, embed)
      embed_to_channel(warning_channel, message, embed) if warning
    end

    def mod_channel
      server.mod_log_channel
    end

    def warning_channel
      server.warning_log_channel
    end

    def embed_to_channel(channel, message, embed)
      channel&.send_message(message, false, embed.to_h, embed.attachments)
    end

    def t(key, **interps)
      I18n.t(key, **interps, scope: i18n_scope)
    end

    def i18n_scope
      "event_logging.#{self.class.name.demodulize.underscore}"
    end
  end
end