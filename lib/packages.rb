module Packages
  extend Enumerable

  SERVER_LOCKS = HashWithIndifferentAccess.new({
    duck: [ServerIds::DUCK, ServerIds::TEST],
  })

  SUPER_GLOBALS = Set['package', 'operator']

  TAGS = 
    Dir['lib/commands/list/*'].map { |dir|
      tag = dir.split('/').last
      [tag, Package.new(tag)]
    }.sort_by { |_tag, pkg| pkg.name }.to_h
  
  class << self
    def [](tag)
      TAGS[tag]
    end

    def each(&block)
      TAGS.each_value(&block)
    end
  end
end