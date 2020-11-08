module Commands
  extend Enumerable

  ALL  = []
  TAGS = {}

  class << self
    delegate :each, to: :all

    def all
      ALL
    end

    def register(command)
      ALL << command
      command.tags.each { |tag| TAGS[tag] = command }
    end
  end
end