module Porygon
  module Tiers
    class TickOperation
      def self.tick
        new.tick
      end

      def tick
        return unless server # can be nil if tick runs during a websocket close

        Porygon::LOGGER.suppress(:ratelimit, :warn) do
          add_role_to_users_with_enough_points
          remove_role_from_users_without_enough_points
        end
      end

      private

      def add_role_to_users_with_enough_points
        MemberPoint.user_ids_with_enough_points(server).each do |user_id|
          next unless (member = server.member(user_id))
          next if member.role?(role)

          member.add_role(role)
          Porygon::LOGGER.task("#{member.username} earned #{role.name}!")
        end
      end

      def remove_role_from_users_without_enough_points
        MemberPoint.user_ids_without_enough_points(server).each do |user_id|
          next unless (member = server.member(user_id))
          next unless member.role?(role)

          member.remove_role(role)
          Porygon::LOGGER.task("#{member.username} lost #{role.name}!")
        end
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