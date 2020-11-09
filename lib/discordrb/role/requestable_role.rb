module Discordrb
  class Role
    class RequestableRole < Sequel::Model
      unrestrict_primary_key

      def self.include?(role)
        where(id: role.id, server_id: role.server.id).present?
      end
    end
  end
end