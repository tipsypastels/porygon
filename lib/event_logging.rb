module EventLogging
  module_function

  def log_join(server, member)
    JoinLogger.log(server, member)
  end

  def log_leave(server, user)
    LeaveLogger.log(server, user)
  end

  def log_ban(server, user)
    BanLogger.log(server, user)
  end

  def log_unban(server, user)
    UnbanLogger.log(server, user)
  end

  def log_delete(channel, message_id)
    DeleteLogger.log(channel, message_id)
  end
end