module Commands
  module Errors
    CommandError = Class.new(StandardError)

    class NoTagsError < CommandError
      def initialize(command)
        super("Command #{command} did not define any tags")
      end
    end

    class NoCallError < CommandError
      def initialize(command)
        super("Command #{command} did not define a #call method")
      end
    end

    class InvalidPackageError < CommandError
      def initialize(command)
        super("Command #{command} does not belong to a valid package.")
      end
    end

    class AlreadyRegistered < CommandError
      def initialize
        super('Commands have already been registered into lists')
      end
    end
  end
end