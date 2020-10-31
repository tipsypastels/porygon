module Commands
  # A command for rolling the dice, with some additional flags that
  # make it easier to use in games.
  class Dice < Command
    self.tags = %w[dice roll diceroll rolldice]
    self.args = Arguments::Parser.new do |a|
      a.arg  :count, Resolvers.int, default: 1
      a.flag :faces, Resolvers.int, default: 6
      a.flag :threshold, Resolvers.int, optional: true
    end

    def call
      return too_many if args.count > 100

      outcomes = []
      total = 0

      args.count.times do 
        res = rand(1..args.faces)
        total += res

        res = "#{res} (#{threshold_text(res)})" if args.threshold
        
        outcomes << res
      end

      print(outcomes, total)
    end

    private

    def print(outcomes, total)
      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('result.title')
        e.description = t('result.description', outcomes: outcomes.join(', '))

        e.field_row do
          e.field(t('result.total'), total) if outcomes.count > 1
          e.field(t('result.threshold'), args.threshold)
        end
      end
    end

    def threshold_text(value)
      t("threshold.#{value >= args.threshold ? 'pass' : 'fail'}")
    end

    def too_many
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('too_many.title', count: args.count)
        e.description = t('too_many.description')
      end
    end
  end
end