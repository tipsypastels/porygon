module EventLogging
  class UnbanLogger < EventLogger
    attr_reader :user
    
    def initialize(server, user)
      super(server)
      @user = user
    end

    def log
      embed do |e|
        e.color  = Porygon::COLORS.info
        e.author = user

        if unban
          e.title = t('unbanned', name: user.username, mod: unban.author.username)
          e.desc  = t('reason', reason: unban.reason || t('no_reason'))
        else
          e.title = t('log_missing.title', name: user.username)
          e.desc  = t('log_missing.desc')
        end
      end
    end

    private

    def unban
      @unban ||=
        begin
          service = AuditLogService.new(server)
          service.fetch(user, :member_ban_remove)
        end
    end
  end
end