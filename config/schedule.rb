set :output, './cron_log.log'

every 24.hours, at: '12:00am' do
  rake 'cleanup:message_cache'
end

every 30.minutes do
  rake 'tick:activity'
end