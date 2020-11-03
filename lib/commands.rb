module Commands
  extend Enumerable, Registrable

  ALL  = []
  TAGS = {}

  StaticError  = TranslatedError.new('command_env.errors.static')
  UsageError   = TranslatedError.new('command_env.errors.usage')
  ResolveError = TranslatedError.new('command_env.errors.resolvers')

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