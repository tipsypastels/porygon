class AuditLogService
  LOOP = 10
  INTERVAL = 5
  
  attr_reader :server
  delegate :audit_logs, to: :server
  
  def initialize(server)
    @server = server
  end
  
  # audit logs may come in either before or way after an event triggers
  # we have to jump through some hoops to get it reliably
  # this was split into several methods but it turns out to
  # be very interdependent and its just easier to bend
  # the rules
  # rubocop:disable Metrics/MethodLength
  def listen(target, action)
    Porygon::LOGGER.info('Searching for audit logs relating to the last event...')

    prev = echo_prev(server)
    prev_time = prev&.creation_time.to_i

    LOOP.times do |i|
      latest = audit_logs(limit: 1, action: action).latest
      latest_time = latest.creation_time.to_i if latest

      if latest && latest.target == target && latest_time > prev_time
        Porygon::LOGGER.info("Found after #{i} iterations.")

        if prev
          prev.update(creation_time: latest.creation_time)
        else
          echo_create(creation_time: latest.creation_time, server_id: server.id)
        end

        return latest
      end

      sleep INTERVAL
    end

    Porygon::LOGGER.info('None were found.')
    nil
  end
  # rubocop:enable Metrics/MethodLength
  
  delegate :prev, :create, to: :EchoedAuditLog, prefix: :echo

  class EchoedAuditLog < Sequel::Model
    unrestrict_primary_key

    def self.prev(server)
      where(server_id: server.id).first
    end
  end
end