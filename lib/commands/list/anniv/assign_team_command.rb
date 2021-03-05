module Commands
  class AssignTeamCommand < Command
    register 'assignteam'

    TEAMS = Porygon::DiscordAnniversary::TEAMS
    
    def call
      return already_has if TEAMS.include? author

      team = TEAMS.add_to_random(author)

      embed do |e|
        e.color = team.color
        e.title = t('done', team: team)
      end
    end

    private

    def already_has
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('already_has')
      end
    end
  end
end