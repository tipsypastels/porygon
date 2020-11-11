module Commands
  class RemoveModLogChannelCommand < Command
    register 'removemodlogchannel', 
      permissions: { member: :manage_server }

    def call
      return no_such_channel unless server.mod_log_channel

      server.mod_log_channel = nil

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('done.title')
        e.desc  = t('done.desc')
      end
    end

    private

    def no_such_channel
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('none.title')
        e.desc  = t('none.desc')
      end
    end
  end
end