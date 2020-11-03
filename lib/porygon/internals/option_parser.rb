module Porygon
  module Internals
    class OptionParser < ::OptionParser
      def add_officious
        # no-op
      end

      def banner
        unless @banner
          @banner = +program_name
          visit(:add_banner, @banner)
        end

        @banner
      end
    end
  end
end