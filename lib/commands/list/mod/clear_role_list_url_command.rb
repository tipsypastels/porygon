module Commands
  class ClearRoleListUrlCommand < Command
    register 'clearrolelisturl', permissions: { member: :manage_server }

    def call
      server.role_list_url = nil

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('done.title')
        e.desc  = t('done.desc')
      end
    end
  end
end