module Porygon
  COLORS = OpenStruct.new(
    ok: 0x11806a,
    info: 0x51509c,
    error: 0xf25e81,
    warning: 0xffff00,
  ).freeze
  
  def self.spawn_bot
    Porygon::Internals::BotClass.new
  end

  def self.prefix
    ENV.fetch('COMMAND_PREFIX', '!')
  end

  def self.owner_proc
    @owner_proc ||= proc { |msg| ENV['OWNER'] == msg.author.id.to_s }
  end
end