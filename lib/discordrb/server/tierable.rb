module Discordrb
  class Server
    module Tierable
      def each_top_tier_member(limit:)
        top_tier_members(limit).each do |entry|
          next unless (member = member(entry[:user_id]))
          yield member, entry[:points]
        end
      end

      private

      def top_tier_members(limit)
        Porygon::Tiers.top(self, limit)
      end
    end
  end
end