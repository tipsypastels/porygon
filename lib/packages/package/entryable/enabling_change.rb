module Packages
  class Package
    module Entryable
      class EnablingChange
        attr_reader :package, :server, :before, :after

        def initialize(package, server)
          @package = package
          @server  = server

          @before = package.channels(server)
          yield
          @after = package.channels(server)
        end
      end
    end
  end
end