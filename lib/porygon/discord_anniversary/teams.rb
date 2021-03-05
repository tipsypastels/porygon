module Porygon
  module DiscordAnniversary
    class Teams
      include Enumerable

      delegate :each, :sample, to: :@teams
      
      def initialize(*teams)
        @teams = teams
      end

      def update_embed(message)
        embed = EmbedBuilder.build do |e|
          e.title = 'Scoreboard'

          each do |team|
            team.into_embed(e)
          end
        end

        message.edit('', embed)
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