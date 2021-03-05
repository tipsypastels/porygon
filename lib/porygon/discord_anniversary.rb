module Porygon
  module DiscordAnniversary
    if Porygon.development?
      SERVER = ServerIds::TEST
      ROLE = 777629541740314645
      
      SCOREBOARD = Scoreboard.new \
        message_id: 817490905224445972, 
        channel_id: 775276838045220914

      TEAMS = Teams.new \
        Team.new(role_id: 817479186435670086, emoji_id: 817483827898220574),
        Team.new(role_id: 817479192252776458, emoji_id: 817483868529098863)
    else
      SERVER = ServerIds::POKE
      ROLE = 817469902272462850

      SCOREBOARD = Scoreboard.new \
        message_id: 817490736328867870, 
        channel_id: 817473503724699688

      TEAMS = Teams.new \
        Team.new(role_id: 817460530280923176, emoji_id: 817489034997268480),
        Team.new(role_id: 817460533841100880, emoji_id: 817489047576379394)
    end
  end
end