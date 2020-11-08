class AuditLogService
  MAX_TIME_DIFF_TO_BE_CONSIDERED_RELEVANT = 3

  attr_reader :server
  delegate :audit_logs, to: :server

  def initialize(server)
    @server = server
  end

  def latest_for_target(target, action)
    log = audit_logs(limit: 1, action: action).latest
    log if log && within_time_range?(log) && log.target == target
  end

  private

  def within_time_range?(log)
    (Time.now - log.creation_time) <= MAX_TIME_DIFF_TO_BE_CONSIDERED_RELEVANT
  end
end