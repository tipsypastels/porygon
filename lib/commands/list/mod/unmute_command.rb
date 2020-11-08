module Commands
  class UnmuteCommand < Command
    register %w[unmute unsilence], 
      permissions: { bot: :manage_roles, member: :manage_roles }

    args do |a|
      a.arg :member, Discordrb::Member
      a.opt :reason, String, optional: true
    end

    def call(member:, reason:)
      member.remove_role(role, reason)

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('unmuted.title', member: member.display_name)
      end
    end

    private

    def role
      server.muted_role || raise(UsageError.new('no_muted_role', no_help: true))
    end
  end
end