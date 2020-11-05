module Packages
  extend Enumerable

  TAGS = {}.with_indifferent_access
  
  class << self
    def each
      TAGS.each_value(&block)
    end

    private

    def define_package(name, global: false, **opts)
      klass = global ? GlobalPackage : Package
      const_set(name.upcase, klass.new(name, **opts))
    end
  end

  define_package :games
  define_package :games_duck_only, server_ids: [ServerIds::DUCK]
  define_package :ai,              server_ids: [ServerIds::DUCK]

  define_package :globals, global: true
  define_package :pacman,  global: true
  define_package :meta,    global: true

  define_package :mod
end