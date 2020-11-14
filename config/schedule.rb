set :output, './cron_log.log'

every 24.hours, at: '12:00am' do
  rake 'cleanup:message_cache'
end

every 15.minutes do
  rake 'cycle:activity'
end