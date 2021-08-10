module Porygon
  module BoundRoles
    class BoundRoleUser < Sequel::Model
      many_to_one :bound_role

      def self.find_by_member(member)
        join(:bound_roles, id: :bound_role_id)
          .where(user_id: member.id, 'bound_role.server_id': member.server.id)
          .to_a
      end
    end
  end
end