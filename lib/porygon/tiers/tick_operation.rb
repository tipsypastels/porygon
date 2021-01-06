module Porygon
  module Tiers
    class TickOperation
      def self.tick
        new.tick
      end

      attr_reader :entries

      def initialize
        @entries = preload_entries
        @skip_potential_new_owners = Set.new
      end

      def tick
        Porygon::LOGGER.task('Starting tiers tick operation.')

        tick_existing_owners
        tick_potential_new_owners
      end

      private

      def tick_existing_owners
        role.members.each do |member|
          next unless (points = points(member)) < Tiers::POINTS

          Porygon::LOGGER.task <<~LOG.strip
            #{member.username}##{member.discriminator} has lost their points role, with only #{points} points.
          LOG

          member.remove_role(role)
          skip_as_potential_new_owner(member)
        end
      end

      def tick_potential_new_owners
        entries.each do |user_id, points|
          next if user_id.in? @skip_potential_new_owners
          next unless points >= Tiers::POINTS
          next unless (member = server.member(user_id))
          
          Porygon::LOGGER.task <<~LOG.strip
            #{member.username}##{member.discriminator} has earned a points role, with #{points} points.
          LOG

          member.add_role(role)
        end
      end

      def preload_entries
        DailyPoint.select(:user_id, Sequel.lit('SUM(points) AS points'))
                  .where(server_id: server.id, date: date)
                  .group(:user_id)
                  .as_hash(:user_id, :points)
      end

      def skip_as_potential_new_owner(member)
        @skip_potential_new_owners.add(member.id)
      end

      def date
        Tiers.date_range
      end

      def points(member)
        entries[member.id] || 0
      end

      def role
        server.role(Tiers::ROLE)
      end

      def server
        Bot.servers[Tiers::SERVER]
      end
    end
  end
end