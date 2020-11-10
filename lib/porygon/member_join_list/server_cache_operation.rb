module Porygon
  class MemberJoinList
    class ServerCacheOperation
      def self.cache(server)
        new(server).cache
      end

      attr_reader :server
      delegate :members, to: :server

      def initialize(server)
        @server = server
      end

      def cache
        if server_members_changed_since_last_run?
          build_new_cache
        else
          Porygon::LOGGER.cache \
            "No change in #{server.name} members, reusing old cache."
        end
      end
      
      private
      
      def build_new_cache
        Porygon::LOGGER.cache("Allocating join dates for #{server.name}.")

        MembersCacheOperation.cache(server)
        save_hash_of_members_for_next_run
      end
      
      def server_members_changed_since_last_run?
        !prev_hash || prev_hash != curr_hash
      end

      def prev_hash
        @prev_hash ||= prev_hash_model&.user_ids_hash
      end

      def curr_hash
        @curr_hash ||= members.inject(0) { |acc, mem| acc | mem.id }
      end

      def save_hash_of_members_for_next_run
        if prev_hash_model
          prev_hash_model.update(user_ids_hash: curr_hash)
        else
          ServerUserIdHash.create(id: server.id, user_ids_hash: curr_hash)
        end
      end

      def prev_hash_model
        @prev_hash_model ||= ServerUserIdHash[server.id]
      end

      class ServerUserIdHash < Sequel::Model
        unrestrict_primary_key
      end
    end
  end
end