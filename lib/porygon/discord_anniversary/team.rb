module Porygon
  module DiscordAnniversary
    class Team
      include Porygon.i18n_scope('anniv.team')

      delegate :name, :color, to: :role
      delegate :server, :scoreboard_channel, to: module_parent

      def initialize(role_id:, scoreboard_id:, asset_url:)
        @role_id = role_id
        @scoreboard_id = scoreboard_id
        @asset_url = asset_url
      end

      def update_scoreboard(is_winning: false)
        embed = EmbedBuilder.build do |e|
          e.color = color
          e.title = name.upcase
          e.thumb = @asset_url
          e.desc  = t(is_winning ? 'desc' : 'desc_winning', points: points)
        end

        scoreboard.edit('', embed)
      end

      def points
        @points ||= record&.[](:points) || 0
      end

      def points=(points)
        return dataset.delete if points <= 0

        if dataset.count > 0
          dataset.update(points: points)
        else
          dataset.insert(role_id: @role_id, points: points)
        end

        force_points_query
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

      def force_points_query
        @points = nil
      end

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