module Commands
  class EvalCommand < Command
    self.tags   = %w[eval !]
    self.access = Permission.bot_owner

    self.args = Arguments.new(self, split: :spaces) do |a|
      a.arg :code, String
      a.opt :quiet, optional: true
    end

    def call
      result = eval(args.code) # rubocop:disable Security/Eval
      return if args.quiet

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = 'Evaluated Code'
        e.description = code_block(result, :ruby, inspect: true)
      end
    end
  end
end