set :output, './cron_log.log'

every 1.hour do
  rake 'tiers:tick'
end

every 2.weeks do
  rake 'tiers:next_cycle'
end

every 24.hours, at: '12:00am' do
  rake 'cleanup:message_cache'
end

every 30.minutes do
  rake 'tick:activity'
end