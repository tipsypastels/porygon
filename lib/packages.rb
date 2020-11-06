module Packages
  extend Enumerable

  SERVER_LOCKS = HashWithIndifferentAccess.new({
    ai: [ServerIds::DUCK],
    games_duck_only: [ServerIds::DUCK],
  })

  TAGS = 
    Dir['lib/commands/list/*'].map { |dir|
      tag = dir.split('/').last
      [tag, Package.new(tag)]
    }.to_h
  
  def self.each
    TAGS.each_value(&block)
  end
end