module Commands
  class GlobalIgnoreCommand < Command
    register 'globalignore', permissions: { owner: true }

    args do |a|
      a.arg :member, Discordrb::Member
    end

    def call(member:)
      return no_author if member == author
      return already_ignored(member) if member.global_ignored?

      member.global_ignore(by: author)

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('done.title')
        e.desc  = t('done.desc', member: member.mention)
      end
    end

    private

    def no_author
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('no_author.title')
        e.desc  = t('no_author.desc')
      end
    end

    def already_ignored(member)
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('already.title', member: member.display_name)
        e.desc  = t('already.desc')
      end
    end
  end
end