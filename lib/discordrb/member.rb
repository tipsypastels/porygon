module Discordrb
  class Member
    MENTION_FORMAT = /^<@[!]?([\d]+)>$/

    def self.from_argument(error, name, command)
      command.server.find_member(name) || error[:nonexistant, arg: name]
    end

    def name_matches_query?(query)
      display_name&.casecmp(query)&.zero? || username.casecmp(query).zero?
    end

    def global_ignore(by:)
      IgnoredUser.global_ignore(self, by)
    end

    def global_unignore
      IgnoredUser.global_unignore(self)
    end

    def server_ignore(by:)
      IgnoredUser.server_ignore(self, server, by)
    end

    def server_unignore
      IgnoredUser.server_unignore(self, server)
    end

    def ignore_status
      IgnoredUser.ignore_status(self)
    end

    def ignored?
      ignore_status.present?
    end

    def global_ignored?
      IgnoredUser.global_ignore_status(self).present?
    end

    def server_ignored?
      IgnoredUser.server_ignore_status(self).present?
    end
  end
end