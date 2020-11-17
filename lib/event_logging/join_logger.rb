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

        e.author_with_disc = member

        e.field(t('age'), account_age)
        e.field(t('id'), code_block(member.id))
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
      Bot.member_join_list << member
    end
    
    def account_age
      base = time_ago_in_words(member.creation_time)
      base += t('days', count: days_since_creation) unless base[/days?/]
      base
    end

    SECONDS_PER_DAY = 86_400

    def days_since_creation
      ((Time.now - member.creation_time) / SECONDS_PER_DAY).round
    end
  end
end