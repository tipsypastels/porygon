class IgnoredUser < Sequel::Model
  class << self
    def global_ignore(user, mod)
      create user_id: user.id, mod_id: mod.id
    end

    def global_unignore(user)
      where(user_id: user.id, server_id: nil).delete
    end

    def server_ignore(user, server, mod)
      create user_id: user.id, server_id: server.id, mod_id: mod.id
    end

    def ignore_status(user)
      return if Bot.owner?(user)

      case user
      when Discordrb::Member
        global_ignore_status(user) || server_ignore_status(user)
      else
        global_ignore_status(user)
      end
    end

    def server_ignore_status(member)
      :server if where(user_id: member.id, server_id: member.server.id).present?
    end

    def global_ignore_status(user)
      :global if where(user_id: user.id, server_id: nil).present?
    end
  end

  def validate
    super
    errors.add(:user_id, 'no_bot_owner') if user_id == ENV['OWNER'].to_i
  end
end