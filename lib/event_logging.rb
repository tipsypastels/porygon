module EventLogging
  module_function

  def log_join(server, member)
    JoinLogger.new(server, member).log
  end

  def log_leave(server, user)
    LeaveLogger.new(server, user).log
  end
end