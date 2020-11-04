class IgnoredUser < Sequel::Model
  class << self
    def ignore(user, by:)
      case user
      when Discordrb::Member
        create user_id: user.id, 
               server_id: user.server.id,
               ignored_by_user_id: by.id
      else
        create user_id: user.id, ignored_by_user_id: by.id 
      end
    end

    def unignore(user)
      case user
      when Discordrb::Member
        where(user_id: user.id, server_id: user.server.id).delete
      else
        where(user_id: user.id, server_id: nil).delete
      end
    end

    def ignored?(user)
      case user
      when Discordrb::Member
        ignored_on_server_or_globally?(user)
      else
        ignored_on_server?(user)
      end
    end

    private
    
    def ignored_on_server_or_globally?(member)
      where(user_id: member.id, server_id: [member.server.id, nil]).present?
    end

    def ignored_globally?(user)
      where(user_id: user.id, server_id: nil).present?
    end
  end

  def validate
    super
    errors.add(:user_id, 'no_bot_owner') if user_id == ENV['OWNER'].to_i
  end
end