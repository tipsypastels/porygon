module Commands
  class AddRoleCommand < Command
    register 'addrole'

    args do |a|
      a.arg :role, Discordrb::Role
    end

    def call(role:)
      return not_requestable(role) unless role.requestable?
      return already_has if author.role?(role)

      author.add_role(role)

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('given', role: role.name)
      end
    end

    private

    def not_requestable(role)
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('not_requestable.title', role: role.name)
        
        if (url = server.role_list_url)
          e.desc = t('not_requestable.desc_for_list', url: url)
        end
      end
    end

    def already_has
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('already_has')
      end
    end
  end
end