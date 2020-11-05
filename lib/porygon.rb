module Porygon
  COLORS = OpenStruct.new(
    ok: 0x11806a,
    info: 0x51509c,
    error: 0xf25e81,
    warning: 0xffff00,
  ).freeze
  
  class << self
    def spawn_bot
      Porygon::Internals::BotClass.new
    end

    def Asset(name) # rubocop:disable Naming/MethodName
      Asset.new(name)
    end
  end
end