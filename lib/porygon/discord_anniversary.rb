module Porygon
  module DiscordAnniversary
    module_function

    if Porygon.development?
      SERVER = ServerIds::TEST
      HELPER = 777629541740314645
      SCOREBOARD = 775276838045220914

      TEAM_DIAMOND = Team.new \
        role_id:  817479186435670086,
        scoreboard_id: 817522355239911446,
        asset_url: 'https://i.imgur.com/MgZ442q.png'

      TEAM_PEARL = Team.new \
        role_id: 817479192252776458,
        scoreboard_id: 817522355965394966,
        asset_url: 'https://i.imgur.com/rphXYpt.png'

      TEAMS = Teams.new TEAM_DIAMOND, TEAM_PEARL
    else
      SERVER = ServerIds::POKE
      HELPER = 817469902272462850
      SCOREBOARD = 817473503724699688

      TEAM_DIAMOND = Team.new \
        role_id: 817460530280923176,
        scoreboard_id: 817522244594827335,
        asset_url: 'https://i.imgur.com/MgZ442q.png'

      TEAM_PEARL = Team.new \
        role_id: 817460533841100880,
        scoreboard_id: 817522272427966505,
        asset_url: 'https://i.imgur.com/rphXYpt.png'

      TEAMS = Teams.new TEAM_DIAMOND, TEAM_PEARL
    end

    def team(name)
      TEAMS[name]
    end

    def scoreboard_update
      TEAMS.update_scoreboards
    end

    def scoreboard_channel
      server.channels.find { |ch| ch.id == SCOREBOARD }
    end

    def server
      Bot.servers[SERVER]
    end
  end
end