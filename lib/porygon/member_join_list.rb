module Porygon
  class MemberJoinList
    def initialize(bot)
      @bot = bot
    end
    
    def build
      log do
        @bot.servers.each_value { |server| cache server }
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

    def find(server, user)
      MemberJoinDate.where(user_id: user.id, server_id: server.id)
    end

    def cache(server)
      Porygon::LOGGER.info("Allocating join dates for #{server.name}.")
      server.members.each { |member| self << member }
    end

    def log
      Porygon::LOGGER.info('Allocating join dates. Prepare for lag!')

      yield

      Porygon::LOGGER.info('All join dates have been allocated.')
    end

    class MemberJoinDate < Sequel::Model
    end
  end
end