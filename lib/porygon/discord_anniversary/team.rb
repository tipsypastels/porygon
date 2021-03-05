module Porygon
  module DiscordAnniversary
    class Team
      delegate :name, :color, to: :role
      delegate :server, :scoreboard_channel, to: module_parent

      def initialize(role_id:, scoreboard_id:, asset_url:)
        @role_id = role_id
        @scoreboard_id = scoreboard_id
        @asset_url = asset_url
      end

      def update_scoreboard
        embed = EmbedBuilder.build do |e|
          e.color = color
          e.title = name.upcase
          e.thumb = @asset_url
          e.desc  = "#{MessageFormatter.bold(points)} Points"
        end

        scoreboard.edit('', embed)
      end

      def points
        record&.[](:points) || 0
      end

      def points=(points)
        return dataset.delete if points <= 0

        if dataset.count > 0
          dataset.update(points: points)
        else
          dataset.insert(role_id: @role_id, points: points)
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

      private

      def scoreboard
        @scoreboard ||= scoreboard_channel.load_message(@scoreboard_id)
      end

      def role
        @role ||= server.role(@role_id)
      end

      def record
        dataset.first
      end

      def dataset
        Database[:anniv_team_points].where(role_id: @role_id)
      end
    end
  end
end