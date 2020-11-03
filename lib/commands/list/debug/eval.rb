module Commands
  # A developer-only command that runs arbitrary ruby for debugging.
  class Eval < Command
    self.tags   = %w[eval !]
    self.access = Porygon.owner_proc

    self.args = Arguments.new(self, no_shellwords: true) do |a|
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