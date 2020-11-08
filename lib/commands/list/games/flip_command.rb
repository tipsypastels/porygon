module Commands
  class FlipCommand < Command
    register %w[flip coin flipcoin coinflip]
    
    args do |a|
      a.opt :heads, String, default: t('default.heads')
      a.opt :tails, String, default: t('default.tails')
    end

    def call(heads:, tails:)
      res = rand > 0.5 ? heads : tails

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('result.title')
        e.desc  = "#{res}!"
      end
    end
  end
end