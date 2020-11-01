module Commands
  class Command
    include Porygon::MessageFormatter
    include Resolvers
    
    include Packaged, Respondable, Taggable, Rescuable
    include Translatable, Documentable

    class << self
      def to_command_s
        "#{Bot.prefix}#{tag}"
      end

      def to_help_s
        "#{Bot.prefix}help #{tag}"
      end

      attr_accessor :access, :server_only

      attr_writer :args

      def args
        @args || Arguments::None
      end
    end

    attr_reader :message, :args, :used_tag
    delegate :channel, to: :message
    delegate :server, to: :channel
    delegate :access, :to_command_s, :to_help_s, :server_only, :usage, 
             to: :class
  
    def initialize(message, used_tag, raw_args)
      @message  = message
      @used_tag = used_tag
      @raw_args = raw_args
    end
    
    def begin_call
      with_error_handling do
        parse_args_and_infer_call_method
        send(@call) if should_call?
      end
    end

    private

    def parse_args_and_infer_call_method
      case (parse_result = self.class.args.parse(@raw_args, self))
      when Arguments::ResultWrapperWithDynamicMethod
        @args = parse_result.value
        @call = parse_result.call_method
      else
        @args = parse_result
        @call = :call
      end
    end

    def should_call?
      return false if @aborted
      return false if invalid_access?
      return false if used_in_invalid_context?

      true
    end

    def invalid_access?
      access && !access.call(message)
    end

    def used_in_invalid_context?
      !message.channel.server && server_only
    end
  end
end