module Packages
  class Package
    module Entryable
      def enable(server, channels)
        enabling(server) do
          if (entry = self.entry(server))
            entry.enable(channels)
          else
            EnabledPackage.create()
          end
        end
      end

      def entry(server)
        @entries[server.id] ||= EnabledPackage.for(self, server)
      end

      def enabled_in_at_least_one_channel?(server)
        super_global? || entry(server).present?
      end

      def enabled?(channel)
        super_global? || entry(channel.server)&.include?(channel)
      end

      def super_global?
        tag.in? Packages::SUPER_GLOBALS
      end

      private

      def enabling(server, &block)
        EnablingChange.new(self, server, &block)
      end
    end
  end
end