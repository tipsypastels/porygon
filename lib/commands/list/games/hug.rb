module Commands
  class Hug < Command
    self.tag  = 'hug'
    self.args = Arguments::Parser.new do |a|
      a.arg :hugged, StringResolver
    end

    def call
      embed do |e|
        e.color = Porygon::COLORS.ok 
        e.title = "You hug **#{args.hugged}**!"
        e.description = ":hugging: **#{args.hugged}**'s #{stat} rose!"
      end
    end

    private

    STATS = [
      'Attack', 'Defense', 'Speed', 
      'Special Attack', 'Special Defense', 'HP'
    ]

    def stat
      STATS.sample
    end
  end
end