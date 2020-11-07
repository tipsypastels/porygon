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
        e.color  = Porygon::COLORS.error
        e.title  = t('left')
        e.author = user

        e.field(t('name'), user.username)
        e.field(t('joined_at'), joined_at)
        e.field(t('discriminator'), code(user.discriminator))
        e.field(t('id'), code(user.id))
      end

      remove_from_cache
    end

    private

    def log_in_console
      Porygon::LOGGER.info \
        t 'left_console', name: user.username, 
                          discrim: user.discriminator,
                          id: user.id,
                          server: user.name
    end

    def joined_at
      time = Bot.member_join_cache.user(server, user)
      time&.strftime(TIME_FORMAT) || t('joined_at_unknown')
    end

    def remove_from_cache
      Bot.member_join_cache.delete_user(server, user)
    end
  end
end