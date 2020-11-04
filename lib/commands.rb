module Commands
  extend Enumerable, Registrable

  ALL  = []
  TAGS = {}

  StaticError  = TranslatedError.new('command_env.errors.static')
  RuntimeError = TranslatedError.new('command_env.errors.runtime')

  class << self
    delegate :each, to: :all

    def all
      ALL
    end

    def listable_for(message)
      select { |command| command.listable_for?(message) }
    end
  end
end