module Porygon
  module DiscordAnniversary
    Team = Struct.new(:role_id, :emoji_id, keyword_init: true) do
      delegate :name, :color, to: :role

      def points
        record&.[](:points) || 0
      end

      def points=(points)
        return dataset.delete if points <= 0

        if dataset.count > 0
          dataset.update(points: points)
        else
          dataset.insert(role_id: role_id, points: points)
        end
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

      def into_embed(embed)
        embed.field(name.upcase, "**#{points}** #{emoji}")
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

      def record
        dataset.first
      end

      def dataset
        Database[:anniv_team_points].where(role_id: role_id)
      end
    end
  end
end