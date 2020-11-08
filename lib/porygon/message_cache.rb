module Porygon
  class MessageCache
    CACHE_SIZE = 1500

    delegate :[], :size, to: :@cache

    def initialize(bot)
      bot.message(&method(:handle))
      @cache = Porygon::HashWithLimitedSize.new(CACHE_SIZE)
    end

    def delete(message)
      @cache.delete(message.id)
    end

    private

    def handle(event)
      return unless event.message.server
      @cache[event.message.id] = event.message
    end
  end
end