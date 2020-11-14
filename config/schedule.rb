set :output, './cron_log.log'

every 24.hours do
  rake 'cleanup:message_cache'
end