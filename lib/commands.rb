module Commands
  extend Enumerable, Registrable

  ALL  = []
  TAGS = {}

  StaticError  = TranslatedError.new('command_env.errors.static')
  UsageError   = TranslatedError.new('command_env.errors.usage')
  ResolveError = TranslatedError.new('command_env.errors.resolvers')

  delegate :each, to: :ALL
end