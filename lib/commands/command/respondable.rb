module Commands
  class Command
    module Respondable
      def say(message)
        channel.send_message(clean_everyone_and_here(message))
      end

      def embed(message = nil, &block)
        embed = Porygon::EmbedBuilder.build(&block)
        message = clean_everyone_and_here(message)
        channel.send_message(message, false, embed.to_h, embed.attachments)
      end
    end
  end
end