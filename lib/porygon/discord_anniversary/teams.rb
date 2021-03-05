module Porygon
  module DiscordAnniversary
    class Teams
      include Enumerable

      delegate :each, :sample, to: :@teams
      
      def initialize(*teams)
        @teams = teams
      end

      def update_scoreboards
        each(&:update_scoreboard)
        true
      end

      def find_by_name

      end

      def include?(member)
        any? { |team| team.include? member }
      end

      def add_to_random(member)
        sample.tap { |team| team << member }
      end
    end
  end
end