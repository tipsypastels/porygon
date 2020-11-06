module Commands
  class EvalCommand < Command
    self.tags   = %w[eval !]
    self.access = Permission.bot_owner

    args split: :spaces do |a|
      a.arg :code, String
      a.opt :quiet, optional: true
    end

    def call(code:, quiet:)
      result = eval(code) # rubocop:disable Security/Eval
      return if quiet

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = 'Evaluated Code'
        e.description = code_block(result, :ruby, inspect: true)
      end
    end
  end
end