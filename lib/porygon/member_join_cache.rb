module Porygon
  class MemberJoinCache
    def initialize(bot)
      @cache = {} 
      @bot   = bot
    end
    
    def build
      @bot.servers.each_value { |server| cache server }
    end

    def member(member)
      user(member.server, member)
    end
    
    def user(server, user)
      @cache[[server.id, user.id]]
    end

    def <<(member)
      @cache[[member.server.id, member.id]] = member.joined_at
    end

    def delete(member)
      delete_user(member.server, member)
    end

    def delete_user(server, user)
      @cache.delete([server.id, user.id])
    end

    private

    def cache(server)
      server.members.each { |member| self << member }
    end
  end
end