module Commands
  class Permission
    MAP = {}
    VALID_NAMES = Discordrb::Permissions::Flags.values

    class << self
      def method_missing(name, *args, &block)
        return super if args.present? || block
        return super unless name.in?(VALID_NAMES)
        
        MAP[name] ||= new(name)
      end

      def respond_to_missing?(name, include_private = false)
        name.in?(VALID_NAMES) || super
      end

      def bot_owner
        @bot_owner ||= -> message { 
          t('not_bot_owner') unless Bot.owner?(message.author)
        }
      end

      def t(key, **interps)
        I18n.t(key, **interps, scope: 'command_env.logging.permission_error_reasons')
      end
    end

    delegate :t, to: :class

    def initialize(action)
      @action = action
    end

    def call(message)
      if message.author.is_a?(Discordrb::Member)
        unless message.author.permission?(@action, message.channel)
          t('lacks_permission', permission: @action.upcase)
        end
      else
        t('not_a_member')
      end
    end
  end
end