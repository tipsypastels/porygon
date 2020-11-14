module Porygon
  class MemberJoinList
    class MembersCacheOperation
      def self.cache(server)
        new(server).cache
      end
      
      attr_reader :server
      delegate :members, to: :server

      def initialize(server)
        @server = server
        @cached_count = 0
      end

      def cache
        members.each { |mem| cache_member(mem) unless cached?(mem) }

        Porygon::LOGGER.cache <<~LOG.strip
          Created new entries on #{server.name} for #{members.size - @cached_count} users.
        LOG
      end

      private

      def cache_member(member)
        MemberJoinDate.create(user_id: member.id, server_id: server.id) do |entry|
          entry.joined_at = member.joined_at
        end
      end

      def cached?(member)
        member.id.in?(user_ids_in_cache) && (@cached_count += 1)
      end

      def user_ids_in_cache
        @user_ids_in_cache ||=
          MemberJoinDate.where(server_id: server.id)
                        .map(:user_id)
                        .to_set
      end
    end
  end
end