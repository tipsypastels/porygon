module Packages
  module Errors
    PackageError = Class.new(StandardError)

    class GlobalError < PackageError
      def initialize(package)
        super("Package #{package} is global and can't be disabled.")
      end
    end
  end
end