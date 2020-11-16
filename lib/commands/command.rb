module Commands
  class Command
    include Porygon::MessageFormatter
    include CommandDefinition, Respondable, Rescuable, Translatable

    def self.from_argument(error, arg, *)
      TAGS[arg.downcase] || error['nonexistant', arg: arg]
    end

    attr_reader :message, :used_tag, :raw_args
    delegate :channel, :author, to: :message
    delegate :server, to: :channel
    delegate :access, :allow_dm, :usage, to: :class
  
    def initialize(message, used_tag, raw_args)
      @message  = message
      @used_tag = used_tag
      @raw_args = raw_args
    end
    
    def begin_call
      return unless should_call?
      
      with_error_handling do
        call_with_args
        CommandLogger.used_command(self)
      end
    end

    private

    def call_with_args
      self.class.args ? call(**parse_args) : call
    end

    def parse_args
      self.class.args&.parse(raw_args, self)
    end

    def should_call?
      return false if @aborted
      return false if invalid_access?
      return false if disabled_in_channel?
      return false if used_by_ignored_user?

      true
    end

    def invalid_access?
      !permission.check(self)
    end

    def disabled_in_channel?
      unless package.enabled?(channel)
        CommandLogger.disabled_command(self)
        true
      end
    end

    def used_by_ignored_user?
      if (status = author.ignore_status)
        CommandLogger.ignored_command(self, status)
        true
      end
    end
  end
end