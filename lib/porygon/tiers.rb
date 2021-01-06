module Porygon
  module Tiers
    # rubocop:disable Style/NumericLiterals
    if Porygon.development?
      ROLE   = 775261617805459486
      SERVER = ServerIds::TEST
      RANGE  = 1.day
      POINTS = 10
    else
      ROLE   = 531984098038775842
      SERVER = ServerIds::POKE
      RANGE  = 2.weeks
      POINTS = 350
    end

    POINTS_PER_MESSAGE = Hash.new(1).tap do |hash|
      hash[775630182521634846] = 0 # a (test server)

      hash[185850117918556161] = 0 # discordia
      hash[423905036859604993] = 0 # logs
      hash[613756774234718209] = 0 # warnings
      hash[159086206385258496] = 0 # staff
      hash[722939153242652723] = 0 # welcome
      hash[603285325334446090] = 0 # server-suggestions
      hash[162925288362082304] = 0 # random
      hash[469134262462054400] = 0 # bot-testing
      hash[469134365952049193] = 0 # bot-discussion
      hash[582487187409469440] = 0 # bot-command-spam

      hash[222724364276072448] = 2 # writers-desk
      hash[182278504648278017] = 2 # artist-studio
      hash[211178182856933376] = 2 # trading-card-game
      hash[239067868174483456] = 2 # anime-and-manga
    end
    # rubocop:enable Style/NumericLiterals
    
    class << self
      def handle(message)
        return if message.author.bot_account?
        return if (points = points_for(message)).zero?

        AddOperation.add(message.server, message.author, points)
      end

      def save
        AddOperation.save
      end

      def tick
        TickOperation.tick
      end

      def garbage_collect
        DailyPoint.garbage_collect
      end

      def fetch(member)
        DailyPoint
          .where(user_id: member.id, server_id: member.server.id, date: date_range)
          .sum(:points) || 0 
      end

      def top(server, limit)
        DailyPoint.select(:user_id, Sequel.lit('SUM(points) AS points'))
                  .where(server_id: server.id, date: date_range)
                  .group(:user_id)
                  .order(Sequel.desc(:points))
                  .limit(limit)
      end

      def delete(server, user)
        DailyPoint.where(user_id: user.id, server_id: server.id).destroy
      end

      def date_range
        RANGE.ago..Time.now
      end

      private
      
      def points_for(message)
        return 0 unless message.server&.id == SERVER
  
        POINTS_PER_MESSAGE[message.channel.id]
      end
    end
  end
end