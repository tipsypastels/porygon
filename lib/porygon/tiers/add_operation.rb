module Porygon
  module Tiers
    class AddOperation
      CACHE = {}

      def self.add(server, member, points)
        if (cached = CACHE[[server.id, member.id]])
          cached.points += points
          cached
        else
          new(server, member, points)
        end
      end

      def self.save
        CACHE.each_value(&:save)
        CACHE.clear
      end

      attr_reader :server, :member
      attr_accessor :points

      def initialize(server, member, points)
        @server = server
        @member = member
        @points = points

        persist_until_next_sweep
      end

      def inspect
        "<Porygon::Tiers::AddOperation #{points}>"
      end

      def save
        if entry
          entry.update(points: entry.points + points)
        else
          DailyPoint.create(**interps, points: points)
        end
      end

      private

      def persist_until_next_sweep
        CACHE[[server.id, member.id]] = self
      end

      def entry
        @entry ||= DailyPoint.where(**interps).first
      end

      def interps
        @interps ||= { server_id: server.id, user_id: member.id, date: date }
      end

      def date
        @date ||= Time.now.beginning_of_day
      end
    end
  end
end