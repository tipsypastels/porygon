class AuditLogService
  LOOP = 10
  INTERVAL = 5

  attr_reader :server
  delegate :audit_logs, to: :server

  def initialize(server)
    @server = server
  end
  
  def fetch(target, action)
    Porygon::LOGGER.info('Searching for audit logs relating to the last event...')
    start = INTERVAL.seconds.ago

    LOOP.times do |i|
      result = fetch_once(target, action, after: start) 

      if result
        Porygon::LOGGER.info("Found after #{i} iterations.")
        return result
      end

      sleep INTERVAL
    end

    Porygon::LOGGER.info('None were found.')
    nil
  end
  
  def fetch_once(target, action, after: INTERVAL.seconds.ago)
    log = audit_logs(limit: 1, action: action).latest
    log if log && comes_after?(log, after) && log.target == target
  end

  private

  def comes_after?(log, start)
    log.creation_time >= start
  end
end