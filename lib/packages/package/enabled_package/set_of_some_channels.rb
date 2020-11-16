module Packages
  class Package
    class EnabledPackage
      class SetOfSomeChannels
        SPLIT = /\s*,\s*/

        def initialize(ids)
          @set = ids.split(SPLIT).map(&:to_i).to_set
        end

        def include?(channel)
          @set.include?(channel.id)
        end

        def channels(server)
          @set.filter_map { |id| server.channel(id) }
        end

        def +(other)
          @set + other.collect(&:resolve_id).to_set
        end
      end
    end
  end
end