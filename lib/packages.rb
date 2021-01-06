module Packages
  extend Enumerable

  SERVER_LOCKS = HashWithIndifferentAccess.new({
    duck: [ServerIds::DUCK, ServerIds::TEST],
    tiers: [Porygon::Tiers::SERVER],
  })

  SUPER_GLOBALS = HashWithIndifferentAccess.new({
    package:  -> member { member.permission?(:manage_server) },
    operator: -> member { Bot.owner?(member) },
  })

  CREATE_PACKAGE = -> dir {
    tag = dir.split('/').last
    [tag, Package.new(tag)]
  }

  TAGS = 
    Dir['lib/commands/list/*'].map(&CREATE_PACKAGE)
                              .sort_by { |_tag, pkg| pkg.name }
                              .to_h
  
  class << self
    def [](tag)
      TAGS[tag]
    end

    def each(&block)
      TAGS.each_value(&block)
    end
  end
end