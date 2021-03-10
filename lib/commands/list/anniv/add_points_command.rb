module Commands
  class AddPointsCommand < Command
    Arg = Struct.new(:team, :amount) do
      def self.from_argument(error, arg, *)
        team_name, amount_str = arg.downcase.split(/\s+/)
        team_name, amount_str = amount_str, team_name if team_name.match?(/^-?\d+$/)
        team_name = "#{team_name}s" unless team_name.end_with?('s')

        team = Porygon::DiscordAnniversary.team(team_name)
        team or error[:unknown_team, arg: team_name]
        amount = Integer(amount_str) rescue error[:invalid_amount, arg: amount_str]
        
        new(team, amount)
      end

      def enact_transaction
        team.points += amount
      end
    end

    register %w[addpoints addpoint]

    args do |a|
      a.arg :arg, Arg      
    end

    def call(arg:)
      unless author.role?(Porygon::DiscordAnniversary::HELPER)
        puts 'too lazy to add a role system to register this codebase is fucked'
        return
      end

      arg.enact_transaction
      scoreboard_update

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('done')
      end
    end

    private

    def scoreboard_update
      Porygon::DiscordAnniversary.scoreboard_update
    end
  end
end