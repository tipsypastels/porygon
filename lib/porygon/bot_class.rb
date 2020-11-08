module Porygon
  class BotClass
    attr_reader :markov, :member_join_cache

    def initialize
      @bot = Discordrb::Bot.new(token: ENV['BOT_TOKEN'])
      @markov = Porygon::MarkovStore.new
      @member_join_cache = MemberJoinCache.new(@bot)

      setup_translation_globals
      setup_handlers
    end

    def start
      @bot.ready { ready }
      @bot.run
    end

    def prefix
      @prefix ||= ENV.fetch('PREFIX', '!')
    end

    def user_id
      @bot.profile.id
    end

    def owner
      @owner ||= ENV.fetch('OWNER').to_i
    end

    def owner?(user)
      user.resolve_id == owner
    end

    private

    def setup_translation_globals
      I18n.config.globals[:prefix] = prefix
    end

    def setup_handlers
      @bot.message(&:handle_message)
      @bot.member_join(&:handle_join)
      @bot.member_leave(&:handle_leave)
    end

    def ready
      Database.start_logging
      @member_join_cache.build
    end
  end
end