module Commands
  class Command
    include Porygon::MessageFormatter
    include Packaged, Respondable, Taggable, Rescuable
    include Translatable, Documentable, Listable

    class << self
      attr_accessor :access, :allow_dm

      def args(**opts, &block)
        return @args unless block_given?
        @args = Arguments.new(self, **opts, &block)
      end

      def from_argument(error, arg, *)
        TAGS[arg.downcase] || error['nonexistant', arg: arg]
      end
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
      return false if used_in_invalid_context?
      return false if used_by_ignored_user?

      true
    end

    def invalid_access?
      return unless access

      if (error_message = access.call(message))
        CommandLogger.permission_error(self, error_message)
        true
      end
    end

    def used_in_invalid_context?
      !message.channel.server && !allow_dm
    end

    def used_by_ignored_user?
      if (status = author.ignore_status)
        CommandLogger.ignored_command(self, status)
        true
      end
    end
  end
end