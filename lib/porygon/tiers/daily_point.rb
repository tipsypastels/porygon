module Porygon
  module Tiers
    class DailyPoint < Sequel::Model
      unrestrict_primary_key

      def self.garbage_collect
        where { date < Tiers::RANGE.ago }.destroy
      end
    end
  end
end