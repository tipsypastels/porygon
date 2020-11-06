module Commands
  class BotUnignoreCommand < Command
    self.tag    = 'botunignore'
    self.access = Permission.ban_members

    args do |a|
      a.arg :member, Discordrb::Member
    end

    def call(member:)
      return not_ignored(member) unless member.server_ignored?

      member.server_unignore

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