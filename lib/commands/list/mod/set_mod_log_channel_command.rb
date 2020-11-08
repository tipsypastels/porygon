module Commands
  class SetModLogChannelCommand < Command
    register 'setmodlogchannel', permissions: { user: :manage_server }

    args do |a|
      a.arg :channel, Discordrb::Channel
    end

    def call(channel:)
      return already_that_channel if server.mod_log_channel == channel
        
      server.mod_log_channel = channel
  
      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('done.title')
        e.desc  = t('done.desc', channel: channel.mention)
      end
    end
    
    private
    
    def already_that_channel
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('already.title')
        e.desc  = t('already.desc')
      end
    end
  end
end