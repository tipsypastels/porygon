module Discordrb
  class User
    def global_ignore(by:)
      IgnoredUser.global_ignore(self, by)
    end

    def ignore_status
      IgnoredUser.ignore_status(self)
    end

    def ignored?
      ignore_status.present?
    end
  end
end