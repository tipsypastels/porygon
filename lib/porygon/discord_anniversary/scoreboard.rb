module Porygon
  module DiscordAnniversary
    Scoreboard = Struct.new(:message_id, :channel_id, keyword_init: true) do
      def update
        DiscordAnniversary::TEAMS.update_embed(message)
      end

      private

      def message
        @message ||= channel.load_message(message_id)
      end

      def channel
        @channel ||= server.channels.find { |ch| ch.id == channel_id }
      end

      def server
        @server ||= Bot.servers[DiscordAnniversary::SERVER]
      end
    end
  end
end