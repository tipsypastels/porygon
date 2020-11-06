module Commands
  class RemoveModLogChannelCommand < Command
    self.tag    = 'removemodlogchannel'
    self.access = Permission.manage_server

    def call
      return no_such_channel unless server.mod_log_channel

      server.mod_log_channel = nil

      embed do |e|
        e.color       = Porygon::COLORS.ok
        e.title       = t('done.title')
        e.description = t('done.description')
      end
    end

    private

    def no_such_channel
      embed do |e|
        e.color       = Porygon::COLORS.warning
        e.title       = t('none.title')
        e.description = t('none.description')
      end
    end
  end
end