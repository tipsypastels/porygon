class BotOwnerAvatarService
  def self.url(...)
    new(...).url
  end

  attr_reader :server
  
  def initialize(server)
    @server = server
  end

  def url
    owner&.avatar_url || fallback
  end

  private

  def owner
    @owner ||= server.member(Bot.owner)
  end

  def fallback
    ENV.fetch('FALLBACK_OWNER_AVATAR', '')
  end
end