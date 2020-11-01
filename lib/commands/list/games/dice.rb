module Commands
  # A command for rolling the dice, with some additional flags that
  # make it easier to use in games.
  class Dice < Command
    self.tags = %w[dice roll diceroll rolldice]
    self.args = Arguments::Parser.new do |a|
      a.arg  :count, Resolvers.int(1..), default: 1
      a.flag :faces, Resolvers.int(1..), default: 6
      a.flag :threshold, Resolvers.int(1..), optional: true
    end

    def call
      return too_many if args.count > 100
      embed_rolls RollList.new(args.count, args.faces, args.threshold)
    end
    
    private
    
    def embed_rolls(rolls)
      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('result.title')
        e.description = t('result.description', outcomes: rolls)
  
        e.field_row do
          e.field(t('result.total'), rolls.total) if rolls.size > 1
          e.field(t('result.pass_fail'), rolls.pass_fail)
          e.field(t('result.threshold'), args.threshold)
        end

        e.footer = t('result.faces', faces: args.faces) if args.faces != 6
      end
    end

    def too_many
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('too_many.title', count: args.count)
        e.description = t('too_many.description')
      end
    end

    class RollList
      attr_reader :rolls, :passes_count, :total, :threshold

      def initialize(size, faces, threshold)
        @rolls        = []
        @total        = 0
        @threshold    = threshold
        @passes_count = 0

        size.times do 
          @rolls << (roll = Roll.new(faces, threshold))
          @passes_count += 1 if roll.pass?
          @total += roll.value
        end
      end

      def pass_fail
        "#{passes_count} / #{fails_count}" if @threshold
      end

      def size
        @rolls.size
      end

      def fails_count
        rolls.size - passes_count
      end

      def to_s
        rolls.join(', ')
      end
    end

    class Roll
      attr_reader :value

      def initialize(faces, threshold)
        @faces     = faces
        @value     = rand(1..faces)
        @threshold = threshold
      end

      def pass?
        return false unless @threshold
        value >= @threshold
      end

      def to_s
        if @threshold
          "#{value} (#{t(pass? ? 'pass' : 'fail')})"
        else
          value.to_s
        end
      end

      private

      def t(key)
        I18n.t(key, scope: 'commands.dice.threshold')
      end
    end
  end
end