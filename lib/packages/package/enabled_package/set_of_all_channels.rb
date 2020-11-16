module Packages
  class Package
    class EnabledPackage
      class SetOfAllChannels
        def initialize(*); end

        def include?(*)
          true
        end

        def channels(server)
          server.text_channels
        end
      end
    end
  end
end