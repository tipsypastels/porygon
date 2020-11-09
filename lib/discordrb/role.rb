module Discordrb
  class Role
    MENTION_FORMAT = /^<@&(\d+)>$/

    def self.from_argument(error, name, command)
      command.server.find_role(name) || error[:nonexistant, arg: name]
    end

    def requestable?
      in? RequestableRole
    end

    def requestable=(req)
      if req
        RequestableRole.find_or_create(id: id, server_id: server.id)
      else
        RequestableRole.where(id: id, server_id: server.id).destroy
      end
    end
  end
end