class FriendCode
  class SetOperation
    def self.from_argument(error, arg, command)
      cons, code = arg.downcase.split(/\s+/)

      # support inverted positions
      code, cons = cons, code if cons.match?(SYNTAX)

      error[:invalid_console, arg: cons] unless cons.in?(CONSOLES)
      error[:missing_console] if cons.blank?
      
      error[:missing_code, no_help: true, cons: cons] if code.blank?
      error[:malformed, arg: code] unless code.match?(SYNTAX)

      new(cons, code, command.author)
    end

    attr_reader :code, :console, :member

    def initialize(console, code, member)
      @member  = member
      @console = console
      @code    = FriendCode.normalize(code)
    end

    def save
      if entry
        entry.update(**update_hash)
      else
        create(**create_hash)
      end
    end

    private

    delegate :create, to: :FriendCode

    def entry
      @entry ||= FriendCode[member.id]
    end

    def create_hash
      update_hash.merge(user_id: member.id)
    end

    def update_hash
      { column => code }
    end

    def column
      CONSOLE_TO_COLUMN.fetch(console)
    end
  end
end