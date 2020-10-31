module Commands
  # A developer-only command that runs arbitrary ruby for debugging.
  class Eval < Command
    self.tags   = %w[eval !]
    self.access = Porygon.owner_proc

    self.args   = Arguments::Parser.new do |a|
      a.arg :code, Resolvers.string
    end

    def call
      result = eval(args.code) # rubocop:disable Security/Eval

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = 'Evaluated Code'
        e.description = code_block(result, :ruby)
      end
    end
  end
end