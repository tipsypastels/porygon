module Packages
  extend Enumerable

  SERVER_LOCKS = HashWithIndifferentAccess.new({
    games_duck_only: [ServerIds::DUCK],
  })

  SUPER_GLOBALS = HashWithIndifferentAccess.new({
    package:  -> member { member.permission?(:manage_server) },
    operator: -> member { Bot.owner?(member) },
  })

  TAGS = 
    Dir['lib/commands/list/*'].map { |dir|
      tag = dir.split('/').last
      [tag, Package.new(tag)]
    }.sort_by { |tag, _pkg| tag }.to_h
  
  class << self
    def [](tag)
      TAGS[tag]
    end

    def each(&block)
      TAGS.each_value(&block)
    end
  end
end