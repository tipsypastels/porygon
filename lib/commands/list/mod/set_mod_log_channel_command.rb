module Commands
  class SetModLogChannelCommand < Command
    self.tag    = 'setmodlogchannel'
    self.access = Permission.manage_server

    args do |a|
      a.arg :channel, Discordrb::Channel
    end

    def call(channel:)
      return already_that_channel if server.mod_log_channel == channel
        
      server.mod_log_channel = channel
  
      embed do |e|
        e.color       = Porygon::COLORS.ok
        e.title       = t('done.title')
        e.description = t('done.description', channel: channel.mention)
      end
    end
    
    private
    
    def already_that_channel
      embed do |e|
        e.color       = Porygon::COLORS.warning
        e.title       = t('already.title')
        e.description = t('already.description')
      end
    end
  end
end