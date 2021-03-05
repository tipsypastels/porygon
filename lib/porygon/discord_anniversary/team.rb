module Porygon
  module DiscordAnniversary
    class Team
      attr_reader :role_id, :name
      delegate :name, :color, to: :role

      def initialize(role_id, emoji_id)
        @role_id = role_id
        @emoji_id = emoji_id
      end

      def include?(member)
        member.role?(role)
      end

      def <<(member)
        member.add_role(role)
      end

      def to_s
        name
      end

      private

      def role
        @role ||= server.role(role_id)
      end

      def emoji
        server.emoji[emoji_id]
      end

      def server
        @server ||= Bot.servers[DiscordAnniversary::SERVER]
      end
    end
  end
end