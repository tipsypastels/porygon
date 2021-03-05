module Porygon
  module DiscordAnniversary
    class Teams
      def initialize(teams_hash)
        @teams_hash = teams_hash
      end

      def include?(member)
        @teams_hash.values.any? { |team| team.include? member }
      end

      def add_to_random(member)
        sample.tap { |team| team << member }
      end

      private

      def sample
        @teams_hash.values.sample
      end
    end
  end
end