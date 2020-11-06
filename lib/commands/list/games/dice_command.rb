module Commands
  class DiceCommand < Command
    self.tags = %w[dice roll diceroll rolldice]

    args do |a|
      a.arg :rolls, DiceRoll, default: -> { DiceRoll.new }
    end

    def call(rolls:)
      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('title')
        e.description = t('description', rolls: describe(rolls))
        
        e.inline do
          e.field(t('total'), rolls.display_total)
          e.field(t('threshold'), rolls.threshold)
          e.field(t('pass_fail'), rolls.pass_fail)
        end
      end
    end

    private

    def describe(rolls)
      rolls.to_s { |pass| t(pass ? 'pass' : 'fail') }
    end
  end
end