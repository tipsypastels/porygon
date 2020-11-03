module Commands
  class Command
    module Respondable
      def say(message)
        channel.send_message(message)
      end

      def embed(message = nil, &block)
        embed = Porygon::EmbedBuilder.build(&block)
        channel.send_message(message, false, embed.to_h, embed.attachments)
      end
    end
  end
end