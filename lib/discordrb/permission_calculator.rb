module Discordrb
  module PermissionCalculator
    private

    def defined_role_permission?(action, channel)
      roles_to_check = [@server.everyone_role] + @roles
      roles_to_check.sort_by(&:position).reduce(false) do |can_act, role|
        channel_allow = permission_overwrite(action, channel, role.id)
        
        # monkey patch to fix discord permissions and overwrites
        # see https://github.com/discordrb/discordrb/pull/712
        if channel_allow
          return true if channel_allow == :allow
          false
        else
          role.permissions.instance_variable_get("@#{action}") || can_act
        end
      end
    end
  end
end