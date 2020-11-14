module Porygon
  class BotClass
    module BotAccount
      extend ActiveSupport::Concern
      
      included do
        delegate :servers, :profile, to: :@bot
        delegate :avatar_url, to: :profile

        callback :init_bot,      on: :init
        callback :init_handlers, on: :init
      end

      def start
        unless ENV['SKIP_BOT']
          @bot.ready { ready }
          @bot.run
        end
      end

      def user_id
        profile.id
      end
      
      def member_on(server)
        server.member(user_id)
      end

      private

      def init_bot
        @bot = Discordrb::Bot.new(token: ENV['BOT_TOKEN'], parse_self: true)
      end

      def init_handlers
        @bot.message(&:handle_message)
        @bot.member_join(&:handle_join)
        @bot.member_leave(&:handle_leave)
        @bot.message_delete(&:handle_delete)
        @bot.user_ban(&:handle_ban)
        @bot.user_unban(&:handle_unban)
        @bot.channel_delete(&:handle_delete)
        @bot.server_role_delete(&:handle_delete)
      end
    end
  end
end