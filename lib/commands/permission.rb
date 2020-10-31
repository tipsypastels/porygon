module Commands
  # Wraps a permission check in a callable interface.
  class Permission
    def initialize(action)
      @action = action
    end

    def call(message)
      if message.author.is_a?(Discordrb::Member)
        return message.author.permission?(@action, message.channel)
      end

      false
    end

    ADMIN = new(:administrator)
    BAN   = new(:ban_members)
  end
end