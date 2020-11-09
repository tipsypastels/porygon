module Commands
  class EvalCommand < Command
    register %w[eval !], permissions: { owner: true }

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
        e.desc  = code_block(result, :ruby, inspect: true)
      end
    end

    private

    # methods provided for ease of use debugging

    def find_role(name)
      Discordrb::Role.from_argument(proc {}, name, self)
    end

    def find_member(name)
      Discordrb::Member.from_argument(proc {}, name, self)
    end
  end
end