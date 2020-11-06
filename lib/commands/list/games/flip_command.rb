module Commands
  class FlipCommand < Command
    self.tags = %w[flip coin flipcoin coinflip]
    
    self.args = Arguments.new(self) do |a|
      a.opt :heads, String, default: t('default.heads')
      a.opt :tails, String, default: t('default.tails')
    end

    def call(heads:, tails:)
      res = rand > 0.5 ? heads : tails

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('result.title')
        e.description = "#{res}!"
      end
    end
  end
end