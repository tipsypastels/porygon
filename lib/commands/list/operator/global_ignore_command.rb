module Commands
  class GlobalIgnoreCommand < Command
    self.tag    = 'globalignore'
    self.access = Permission.bot_owner

    args do |a|
      a.arg :member, Discordrb::Member
    end

    def call(member:)
      p member
    end
  end
end