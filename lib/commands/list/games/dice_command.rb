module Commands
  class DiceCommand < Command
    self.tags = %w[dice roll diceroll rolldice]

    self.args = Arguments.new(self) do |a|
      a.arg :rolls, DiceRoll, default: -> { DiceRoll.new }
    end

    delegate :rolls, to: :args

    def call
      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('title')
        e.description = t('description', rolls: build_description)
        
        e.field_row do
          e.field(t('total'), rolls.display_total)
          e.field(t('threshold'), rolls.threshold)
          e.field(t('pass_fail'), rolls.pass_fail)
        end
      end
    end

    private

    def build_description
      rolls.to_s { |pass| t(pass ? 'pass' : 'fail') }
    end
  end
end