module Porygon
  module Tiers
    class MemberPoint < Sequel::Model
      unrestrict_primary_key

      def self.add(server, member, points)
        Database.fetch(<<~SQL.strip, server.id, member.id, points).to_a
          INSERT INTO member_points (server_id, user_id, points_this_cycle)
          VALUES (?, ?, ?)
          ON CONFLICT ON CONSTRAINT points_pk DO UPDATE
          SET points_this_cycle = (
            member_points.points_this_cycle + excluded.points_this_cycle
          )
        SQL
      end

      def self.fetch(member)
        where(server_id: member.server.id, user_id: member.id).first&.points || 0
      end

      def self.cycle
        dataset.update points_prev_cycle: Sequel[:points_this_cycle], 
                       points_this_cycle: 0
      end

      def self.user_ids_with_enough_points(server)
        where(server_id: server.id)
          .where { points_this_cycle + points_prev_cycle > Tiers::POINTS }
          .pluck(:user_id)
      end

      def self.user_ids_without_enough_points(server)
        where(server_id: server.id)
          .where { points_this_cycle + points_prev_cycle < Tiers::POINTS }
          .pluck(:user_id)
      end

      def self.top(server, limit)
        select(:user_id, Sequel.lit('(points_this_cycle + points_prev_cycle) as points'))
          .where(server_id: server.id)
          .order(Sequel.desc(:points))
          .limit(limit)
      end

      def points
        points_this_cycle + points_prev_cycle
      end
    end
  end
end