module Porygon
  module DiscordAnniversary
    class Teams
      include Enumerable

      def initialize(team1, team2)
        @team1 = team1
        @team2 = team2
      end

      def each
        yield @team1
        yield @team2
      end

      def [](name)
        find { |team| team.name.casecmp(name).zero? }
      end

      def update_scoreboards
        winner = find_winner()
        
        each do |team|
          team.update_scoreboard(is_winning: team == winner)
        end

        true
      end

      def include?(member)
        any? { |team| team.include? member }
      end

      def add_to_random(member)
        sample.tap { |team| team << member }
      end

      private

      def find_winner
        return @team1 if @team1.points > @team2.points
        return @team2 if @team2.points > @team1.points
      end

      def sample
        rand.round.zero? ? @team1 : @team2
      end
    end
  end
end