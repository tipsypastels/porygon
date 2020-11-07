module Commands
  extend Enumerable

  ALL  = []
  TAGS = {}

  class << self
    delegate :each, to: :all

    def all
      ALL
    end

    def listable_for(message)
      select { |command| command.listable_for?(message) }
    end

    def register_all
      Command.descendants.each do |command| 
        register(command) if command.module_parent == Commands
      end
    end

    def register(command)
      ALL << command
      command.tags.each { |tag| TAGS[tag] = command }
    end
  end
end