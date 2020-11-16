module Packages
  class Package
    module CommandGroup
      def commands
        @commands ||= 
          Commands.select { |command| command.package == self }
                  .sort_by(&:tag)
      end
    end
  end
end