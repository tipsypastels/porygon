module EventLogging
  class LeaveLogger < EventLogger
    TIME_FORMAT = '%a, %d %B %Y %I:%M %p GMT'

    attr_reader :user
    
    def initialize(server, user)
      super(server)
      @user = user
    end

    def log
      log_in_console
      
      embed do |e|
        e.color  = Porygon::COLORS.warning
        e.title  = t('left')

        e.author_with_disc = user
        
        e.field(t('joined_at'), joined_at)
        e.field(t('id'), code_block(user.id))
      end
      
      log_embed_for_kick
      remove_from_cache
    end

    private

    def log_in_console
      Porygon::LOGGER.info \
        t 'left_console', name: user.username, 
                          discrim: user.discriminator,
                          id: user.id,
                          server: server.name
    end

    def log_embed_for_kick
      return unless kick
      
      embed(warning: true) do |e|
        e.author_with_disc = user

        e.color  = Porygon::COLORS.warning
        e.title  = t('kick.title', name: user.username, mod: kick.author.username)
        e.desc   = t('kick.reason', reason: kick.reason || t('kick.no_reason'))
      end
    end

    def joined_at
      time = Bot.member_join_list.user(server, user)
      time&.strftime(TIME_FORMAT) || t('joined_at_unknown')
    end

    def remove_from_cache
      Bot.member_join_list.delete_user(server, user)
    end

    def kick
      @kick ||= 
        begin
          service = AuditLogService.new(server)
          service.listen(user, :member_kick)
        end
    end
  end
end