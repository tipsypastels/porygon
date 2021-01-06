set :output, './cron_log.log'

every 5.minutes do
  rake 'tiers:save'
end

every 12.hours do
  rake 'tiers:tick'
end

every 24.hours do
  rake 'tiers:trash'
end

every 24.hours, at: '12:00am' do
  rake 'cleanup:message_cache'
end

every 30.minutes do
  rake 'tick:activity'
end