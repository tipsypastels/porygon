module Porygon
  class BotClass
    module Ownership
      def owner
        @owner ||= @bot.user(owner_id)
      end

      def owner_id
        @owner_id ||= ENV.fetch('OWNER').to_i
      end

      def owner?(user)
        user.resolve_id == owner
      end

      def owner_avatar
        owner.avatar_url || ENV['FALLBACK_OWNER_AVATAR']
      end
    end
  end
end