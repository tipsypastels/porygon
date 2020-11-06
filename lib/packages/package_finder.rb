module Packages
  class PackageFinder
    def self.find(...)
      new(...).find
    end

    attr_reader :error, :name, :command
    delegate :server, :author, to: :command
    
    # TODO: if needed, add a kwarg here for whether to only
    # support packages on this server
    def initialize(error, name, command)
      @error   = error
      @name    = name.downcase
      @command = command
    end

    def find
      package || error[:nonexistant, arg: name]
    end

    private

    def package
      package = Packages[name]
      package if should_return?(package)
    end

    def should_return?(package)
      package && (package.supports?(server) || Bot.owner?(author))
    end
  end
end