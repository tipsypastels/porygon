module Commands
  class MuteCommand < Command
    include CommandMixins::WithMutedRole

    self.tags   = %w[mute silence]
    self.access = Permission.manage_roles

    args do |a|
      a.arg :member, Discordrb::Member
      a.opt :reason, String, optional: true
    end

    def call(member:, reason:)
      with_bot_permission_handling do
        with_muted_role do |role|
          member.add_role(role, reason)

          embed do |e|
            e.color = Porygon::COLORS.ok
            e.title = t('muted.title')
            e.description = t('muted.description')
          end
        end
      end
    end
  end
end