module Commands
  class Permissions
    attr_reader :member_perms, :bot_perms

    def initialize(perms)
      @member_perms = [*perms[:member]]
      @bot_perms    = [*perms[:bot]]
      @owner_only   = perms[:owner]
    end

    def owner_only?
      @owner_only
    end

    def check(command)
      Checker.check(command)
    end
  end
end