module Commands
  class GlobalUnignoreCommand < Command
    self.tag    = 'globalunignore'
    self.access = Permission.bot_owner

    args do |a|
      a.arg :member, Discordrb::Member
    end

    def call(member:)
      return not_ignored(member) unless member.global_ignored?

      member.global_unignore

      embed do |e|
        e.color       = Porygon::COLORS.ok
        e.title       = t('done.title')
        e.description = t('done.description', member: member.mention)
      end
    end

    private

    def not_ignored(member)
      embed do |e|
        e.color       = Porygon::COLORS.warning
        e.title       = t('not_ignored.title', member: member.display_name)
        e.description = t('not_ignored.description')
      end
    end
  end
end