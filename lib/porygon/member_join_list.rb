module Porygon
  class MemberJoinList
    def initialize(bot)
      @bot  = bot
      @done = false
    end
    
    def build
      unless @done
        wait_for_member_list_to_be_accurate

        log do
          @bot.servers.each_value { |server| cache server }
        end

        @done = true
      end
    end

    def member(member)
      user(member.server, member)
    end
    
    def user(server, user)
      find(server, user).get(:joined_at)
    end

    def <<(member)
      find_or_create(user_id: member.id, server_id: member.server.id) do |a|
        a.joined_at = member.joined_at
      end
    end

    def delete_member(member)
      delete_user(member.server, member)
    end

    def delete_user(server, user)
      find(server, user).destroy
    end

    private

    delegate :find_or_create, to: :MemberJoinDate

    WAIT_TIME = 30.seconds

    def wait_for_member_list_to_be_accurate
      return if Porygon.development?

      Porygon::LOGGER.cache \
        "Sleeping for #{WAIT_TIME} seconds until the member list is accurate."

      sleep WAIT_TIME
    end

    def find(server, user)
      MemberJoinDate.where(user_id: user.id, server_id: server.id)
    end

    def cache(server)
      ServerCacheOperation.cache(server, &method(:<<))
    end

    def log
      Porygon::LOGGER.cache('Allocating join dates. Prepare for lag!')

      yield

      Porygon::LOGGER.cache('All join dates have been allocated.')
    end

    class MemberJoinDate < Sequel::Model
    end
  end
end