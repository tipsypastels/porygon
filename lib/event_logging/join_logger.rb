module EventLogging
  class JoinLogger < EventLogger
    include ActionView::Helpers::DateHelper

    attr_reader :member

    def initialize(server, member)
      super(server)
      @member = member
    end
    
    def log
      log_in_console
      add_to_cache
      
      embed do |e|
        e.color  = Porygon::COLORS.ok
        e.title  = t('joined')
        e.author = member

        e.field(t('name'), member.username)
        e.field(t('age'), time_ago_in_words(member.creation_time))
        e.field(t('discriminator'), code(member.discriminator))
        e.field(t('id'), code(member.id))
      end
    end

    private

    def log_in_console
      Porygon::LOGGER.info \
        t 'joined_console', name: member.username, 
                            discrim: member.discriminator,
                            id: member.id,
                            server: server.name
    end

    def add_to_cache
      Bot.member_join_cache << member
    end
  end
end