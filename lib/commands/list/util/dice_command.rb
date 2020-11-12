module Commands
  class DiceCommand < Command
    register %w[dice roll diceroll rolldice]

    args do |a|
      a.arg :rolls, DiceRoll, default: proc { DiceRoll.new }
    end

    def call(rolls:)
      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('title')
        e.desc  = t('desc', rolls: describe(rolls))
        
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