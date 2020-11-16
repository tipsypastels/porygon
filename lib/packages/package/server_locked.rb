module Packages
  class Package
    module ServerLocked
      def server_ids
        Packages::SERVER_LOCKS[tag]
      end

      def server_specific?
        server_ids.present?
      end

      def supports?(server)
        !server_specific? || server.id.in?(server_ids)
      end
    end
  end
end