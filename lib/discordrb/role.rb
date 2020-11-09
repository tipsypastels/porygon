module Discordrb
  class Role
    MENTION_FORMAT = /^<@&(\d+)>$/

    def self.from_argument(error, name, command)
      command.server.find_role(name) || error[:nonexistant, arg: name]
    end

    def requestable?
      in? RequestableRole
    end
  end
end