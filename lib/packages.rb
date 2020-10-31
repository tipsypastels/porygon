module Packages
  extend Enumerable

  TAGS = {}.with_indifferent_access
  
  class << self
    def each
      TAGS.each_value(&block)
    end
  end

  GAMES = Package.new(:games)
  GAMES_DUCK_ONLY = Package.new(:games_duck_only, server_ids: [ServerIds::DUCK])
  AI = Package.new(:ai, server_ids: [ServerIds::DUCK])

  GLOBALS = GlobalPackage.new(:globals)
  PACMAN  = GlobalPackage.new(:pacman)
  DEBUG   = GlobalPackage.new(:debug)
end