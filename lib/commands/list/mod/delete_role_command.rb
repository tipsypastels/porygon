module Commands
  class DeleteRoleCommand < Command
    register 'deleterole', 
      permissions: { bot: :manage_roles, member: :manage_roles }
    
    args do |a|
      a.arg :role, Discordrb::Role
    end

    def call(role:)
      role.delete

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('deleted.title')
        e.desc  = t('deleted.desc')
      end
    end
  end
end