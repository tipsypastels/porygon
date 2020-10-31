module Commands
  # A command for flipping a coin.
  class Flip < Command
    self.tags = %w[flip coin flipcoin coinflip]
    self.args = Arguments::Parser.new do |a|
      a.flag :heads, Resolvers.string, default: t('default.heads')
      a.flag :tails, Resolvers.string, default: t('default.tails')
    end

    def call
      res = rand > 0.5 ? args.heads : args.tails

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('result.title')
        e.description = "#{res}!"
      end
    end
  end
end