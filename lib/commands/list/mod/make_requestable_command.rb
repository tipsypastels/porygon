module Commands
  class MakeRequestableCommand < Command
    register 'makerequestable', permissions: { member: :manage_roles }

    args do |a|
      a.arg :role, Discordrb::Role
      a.opt :unsafe, optional: true
    end

    def call(role:, unsafe:)
      return already_requestable(role) if role.requestable?
      return cant_make_highest_role_requestable if authors_highest_role?(role)
      return cant_make_role_higher_than_bot if role_higher_than_bot?(role)
      return cant_add_role_with_permissions if role_has_permissions?(role, unsafe)

      role.requestable = true

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('done.title', role: role.name)
        e.desc  = t('done.desc', role: role.name)
      end
    end

    private

    def cant_make_highest_role_requestable
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('highest_role')
      end
    end

    def cant_make_role_higher_than_bot
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('higher_than_bot')
      end
    end

    def already_requestable(role)
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('already_requestable', role: role.name)
      end
    end

    def cant_add_role_with_permissions
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('has_permissions.title')
        e.desc  = t('has_permissions.desc', args: raw_args, tag: used_tag)
      end
    end

    def authors_highest_role?(role)
      return false if server.owner == author
      author.highest_role.position <= role.position
    end

    def role_higher_than_bot?(role)
      bot = Bot.member_on(server)
      bot.highest_role.position <= role.position
    end

    def role_has_permissions?(role, unsafe)
      return false if unsafe
      role.permissions != server.everyone_role.permissions
    end
  end
end
