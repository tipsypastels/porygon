module Discordrb
  module Events
    module Respondable
      def send_message(content, tts = false, embed = nil, attachments = nil)
        channel.send_message(content, tts, embed, attachments)
      end

      def send_embed(message = '', embed = nil, attachments = nil, &block)
        channel.send_embed(message, embed, attachments, &block)
      end
    end
  end
end