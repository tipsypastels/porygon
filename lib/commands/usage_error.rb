module Commands
  class UsageError < StandardError
    SCOPE = 'command_env.errors.usage'

    def initialize(key, no_help: false, **interps)
      super I18n.t(key, **interps, scope: SCOPE)
      @no_help = no_help
    end

    def no_help?
      @no_help
    end
  end
end