module Commands
  class Command
    module Respondable
      def say(message)
        channel.send_message(message)
      end

      def embed(message = nil, &block)
        embed = Porygon::EmbedBuilder.build(&block).to_h
        channel.send_message(message, false, embed)
      end
    end
  end
end