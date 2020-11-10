class CommandAccessService
  attr_reader :member, :channel, :command
  delegate :server, to: :channel
  delegate :permission, to: :command
  delegate :member_perms, :bot_perms, :owner_only?, to: :permission

  def initialize(member, channel, command)
    @member    = member
    @channel   = channel
    @command   = command
    @callbacks = {}
  end

  def on(event, callback)
    @callbacks[event] = callback
    self
  end

  def check_all
    check_member && check_bot
  end

  def check_member
    return true if member_is_owner?
    
    if owner_only?
      run_callback(:not_bot_owner)
      return false
    end

    missing = member_perms.find { |perm| !perm?(perm) }

    if missing
      run_callback(:member_lacks_permission, missing)
      return false
    end

    true
  end

  def check_bot
    bot = server.member(Bot.user_id)
    missing = bot_perms.find { |perm| !perm?(perm, bot) }

    if missing
      run_callback(:bot_lacks_permission, missing)
      return false
    end

    true
  end

  private

  def perm?(perm, member = self.member)
    member.permission?(perm, channel)
  end

  def member_is_owner?
    Bot.owner?(member)
  end

  def run_callback(name, *params)
    @callbacks[name]&.call(*params)
  end
end