class FriendCode
  class DeleteConsole
    ALL = 'all'.freeze
    ENUM = CONSOLES + [ALL]

    def self.from_argument(error, arg, command)
      arg = arg.downcase
      error[:invalid, arg: arg] unless arg.in?(ENUM)

      new(arg, command.author)
    end

    attr_reader :console, :member

    def initialize(console, member)
      @console = console
      @member  = member
    end

    def delete
      return unless entry
      return entry.delete if all?

      entry.update(**update_hash)
    end
    
    def all?
      console == ALL
    end

    private
    
    def update_hash
      { column => nil }
    end

    def column
      CONSOLE_TO_COLUMN.fetch(console)
    end

    def entry
      @entry ||= FriendCode[member.id]
    end
  end
end