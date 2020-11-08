module Commands
  class Command
    module Rescuable
      private

      def with_error_handling
        yield
      rescue UsageError => e
        handle_usage_error(e)
      rescue => e
        handle_unknown_error(e)
        Porygon::LOGGER.error(e)
      end

      def handle_usage_error(error)
        @aborted = true
        CommandLogger.usage_error(self)

        embed do |e|
          interps = shared_error_interps

          e.color  = Porygon::COLORS.warning 
          e.title  = I18n.t('base.title', **interps)
          e.footer = I18n.t('base.footer', **interps)
          e.desc   = error.message

          next if error.no_help?

          e.field(I18n.t('base.usage', **interps), usage(@used_tag))
          e.field(I18n.t('base.examples', **interps), examples(@used_tag))
        end
      end

      def handle_unknown_error(error)
        @aborted = true

        embed do |e|
          e.color = Porygon::COLORS.error
          e.title = I18n.t('command_env.errors.unknown.title')
          e.desc  = code_block(error.message)
        end
      end

      def shared_error_interps
        @shared_error_interps ||= 
          { 
            command: @used_tag, 
            scope: 'command_env.errors.usage',
          }
      end
    end
  end
end