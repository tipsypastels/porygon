module Commands
  class DeleteRoleCommand < Command
    self.tag    = 'deleterole'
    self.access = Permission.manage_roles
    
    self.args = Arguments.new(self) do |a|
      a.arg :role, Discordrb::Role
    end

    def call(role:)
      with_bot_permission_handling do
        role.delete

        embed do |e|
          e.color       = Porygon::COLORS.ok
          e.title       = t('deleted.title')
          e.description = t('deleted.description')
        end
      end
    end
  end
end