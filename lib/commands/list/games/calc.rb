module Commands
  # A command that does simple math problems.
  class Calc < Command
    self.tags = %w[calc calculate math]
    self.args = Arguments::Parser.new do |a|
      a.arg :result, EquationResolver
    end

    def call
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('result')
        e.description = args.result
      end
    end
  end
end