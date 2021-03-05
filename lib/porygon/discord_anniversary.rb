module Porygon
  module DiscordAnniversary
    if Porygon.development?
      SERVER = ServerIds::TEST
      ROLE = 777629541740314645
      TEAMS = Teams.new({
        diamonds: Team.new(817479186435670086, 817483827898220574),
        pearls: Team.new(817479192252776458, 817483868529098863),
      })
    else
      SERVER = ServerIds::POKE
      ROLE = 817469902272462850
      TEAMS = Teams.new({
        diamonds: Team.new(817460530280923176, 817489034997268480),
        pearls: Team.new(817460533841100880, 817489047576379394),
      })
    end
  end
end