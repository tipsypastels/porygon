module Porygon
  module Internals
    class BotClass
      attr_reader :db, :logger, :markov

      def initialize
        @db = Database.connect
        @bot = Discordrb::Bot.new(token: ENV['BOT_TOKEN'])
        @logger = Logger.new
        @markov = Porygon::MarkovStore.new

        setup_handlers
      end

      def start
        @bot.run unless ENV['NOSTART']
      end

      def prefix
        @prefix ||= ENV.fetch('PREFIX', '!')
      end

      private

      def setup_handlers
        return if ENV['NOSTART']
        
        @bot.message(&:handle)
      end
    end
  end
end