module EventLogging
  class BanLogger < EventLogger
    attr_reader :user

    def initialize(server, user)
      super(server)
      @user = user
    end

    def log
      embed do |e|
        e.color  = Porygon::COLORS.error
        e.author = user

        if ban
          e.title = t('banned', name: user.username, mod: ban.author.username)
          e.desc  = t('reason', reason: ban.reason || t('no_reason'))
        else
          e.title = t('log_missing.title', name: user.username)
          e.desc  = t('log_missing.desc')
        end
      end
    end

    private

    def ban
      @ban ||= 
        begin
          service = AuditLogService.new(server)
          service.latest_for_target(user, :member_ban_add)
        end
    end
  end
end