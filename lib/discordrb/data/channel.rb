module Discordrb
  class Channel
    # rubocop:disable all
    def send_message(content, tts = false, embed = nil, attachments = nil)
      @bot.send_message(@id, content, tts, embed, attachments)
    end

    def send_temporary_message(content, timeout, tts = false, embed = nil, attachments = nil)
      @bot.send_temporary_message(@id, content, timeout, tts, embed, attachments)
    end

    def send_embed(message = '', embed = nil, attachments = nil)
      embed ||= Discordrb::Webhooks::Embed.new
      yield(embed) if block_given?
      send_message(message, false, embed, attachments)
    end
    # rubocop:enable all
  end
end
