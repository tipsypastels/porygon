module Discordrb
  class Role
    class RequestableRole < Sequel::Model
      unrestrict_primary_key

      class << self
        def include?(role)
          where(id: role.id, server_id: role.server.id).present?
        end

        def garbage_collect(role)
          where(id: role.id, server_id: role.server.id).destroy
        end
      end
    end
  end
end