module Commands
  class SetMutedRoleCommand < Command
    register 'setmutedrole', permissions: { member: :manage_roles }

    args do |a|
      a.arg :role, Discordrb::Role
    end

    def call(role:)
      server.muted_role = role

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('done.title')
        e.desc  = t('done.desc', role: role.mention)
      end
    end
  end
end