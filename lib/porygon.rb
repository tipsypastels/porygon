module Porygon
  COLORS = ColorPalette.new
  LOGGER = Logger.new
  LOCALE = Locale.new
  
  class << self
    def spawn_bot
      Porygon::BotClass.new
    end

    def Asset(name) # rubocop:disable Naming/MethodName
      Asset.new(name)
    end
  end
end