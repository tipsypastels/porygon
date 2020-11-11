module Commands
  class MakeUnrequestableCommand < Command
    register 'makeunrequestable', permissions: { member: :manage_roles }
    
    args do |a|
      a.arg :role, Discordrb::Role
    end

    def call(role:)
      return not_requestable(role) unless role.requestable?

      role.requestable = false

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('done.title', role: role.name)
        e.desc  = t('done.desc', args: raw_args)
      end
    end

    private

    def not_requestable(role)
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('not_requestable', role: role.name)
      end
    end
  end
end