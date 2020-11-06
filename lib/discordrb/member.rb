module Discordrb
  class Member
    MENTION_FORMAT = /^<@[!]?([\d]+)>$/

    def self.from_argument(error, name, command)
      command.server.find_member(name) || error[:nonexistant, arg: name]
    end

    def name_matches_query?(query)
      display_name&.casecmp(query)&.zero? || username.casecmp(query).zero?
    end
  end
end