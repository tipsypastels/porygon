module Discordrb
  class Server
    ROLE_MENTION_FORMAT = /^<@&(\d+)>$/

    def find_role(name)
      if name =~ ROLE_MENTION_FORMAT
        role($1)
      else
        find_role_by_query(name)
      end
    end

    def find_role_by_query(name)
      roles.detect { |role| role.name.casecmp(name).zero? }
    end
  end
end