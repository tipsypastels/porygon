module Porygon
  module BoundRoles
    class BoundRole < Sequel::Model
      one_to_many :bound_role_users

      def validate
        super
        errors.add(:role_id, 'must refer to a valid role') unless role
      end

      def role
        Bot.servers[server_id].role(role_id)
      end
    end
  end
end