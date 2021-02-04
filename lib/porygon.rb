module Porygon
  class << self
    def spawn_bot
      Porygon::BotClass.new
    end

    def Asset(name) # rubocop:disable Naming/MethodName
      Asset.new(name)
    end

    def i18n_scope(scope)
      Module.new do
        define_method(:t) do |key, **interps|
          I18n.t(key, **interps, scope: scope)
        end
      end
    end

    def development?
      ENV.fetch('DEV', false)
    end

    def alive?
      BotClass::CheckAlive.alive?
    end

    def thread_local(value)
      Concurrent::ThreadLocalVar.new(value)
    end
  end

  COLORS   = ColorPalette.new
  LOGGER   = Logger.new
  PORTRAIT = Asset('portrait.png')
end