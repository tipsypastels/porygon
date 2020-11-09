module Commands
  class RemoveRoleCommand < Command
    register 'removerole'

    args do |a|
      a.arg :role, Discordrb::Role
    end

    def call(role:)
      return doesnt_have unless author.role?(role)
      return not_requestable unless role.requestable?

      author.remove_role(role)

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('taken', role: role.name)
      end
    end

    private

    def not_requestable
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('not_requestable')
      end
    end

    def doesnt_have
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('doesnt_have')
      end
    end
  end
end