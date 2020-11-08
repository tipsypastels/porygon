module Commands
  class GlobalUnignoreCommand < Command
    register 'globalunignore', permissions: { owner: true }

    args do |a|
      a.arg :member, Discordrb::Member
    end

    def call(member:)
      return not_ignored(member) unless member.global_ignored?

      member.global_unignore

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('done.title')
        e.desc  = t('done.desc', member: member.mention)
      end
    end

    private

    def not_ignored(member)
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('not_ignored.title', member: member.display_name)
        e.desc  = t('not_ignored.desc')
      end
    end
  end
end