module EventLogging
  class EventLogger
    include Porygon::MessageFormatter

    attr_reader :server

    def initialize(server)
      @server = server
    end

    private

    def embed(message = nil, &block)
      embed = Porygon::EmbedBuilder.build(&block)
      channel&.send_message(message, false, embed.to_h, embed.attachments)
    end

    def channel
      server.mod_log_channel
    end

    def t(key, **interps)
      I18n.t(key, **interps, scope: i18n_scope)
    end

    def i18n_scope
      "event_logging.#{self.class.name.demodulize.underscore}"
    end
  end
end