module Commands
  class Command
    module Rescuable
      private

      def with_error_handling
        yield
      rescue ResolveError => e then handle_resolve_error(e)
      rescue UsageError   => e then handle_usage_error(e)
      rescue => e
        handle_unknown_error(e)
        puts e.message + "\n" + e.backtrace.join("\n")
      end

      # rubocop:disable Metrics/MethodLength
      def handle_resolve_error(error)
        @aborted = true

        embed do |embed|
          build_embed_from_translated_error(embed, error)
          embed.color = Porygon::COLORS.warning 
        end
      end

      def handle_usage_error(error)
        @aborted = true

        embed do |embed|
          build_embed_from_translated_error(embed, error)
          
          embed.color    = Porygon::COLORS.warning 
          embed.title  ||= I18n.t(
            'command_env.errors.usage.default.title',
            **shared_error_interps,
          )

          embed.footer ||= I18n.t(
            'command_env.errors.usage.default.footer',
            **shared_error_interps,
          )

          embed.description ||= I18n.t(
            'command_env.errors.usage.default.description',
            **shared_error_interps,
          )
        end
      end
      # rubocop:enable Metrics/MethodLength

      def handle_unknown_error(error)
        @aborted = true

        embed do |e|
          e.color = Porygon::COLORS.error
          e.title = I18n.t('command_env.errors.unknown.title')
          e.description = code_block(error.message)
        end
      end

      def build_embed_from_translated_error(embed, error)
        value = error.translated_value

        case value
        when String
          embed.title = value
        when Hash
          embed.title       = error[:title, **shared_error_interps]
          embed.footer      = error[:footer, **shared_error_interps]
          embed.description = error[:description, **shared_error_interps]
        end
      end

      def shared_error_interps
        @shared_error_interps ||= 
          { 
            command: @used_tag, 
            usage: usage(@used_tag), 
            prefix: Bot.prefix, 
          }
      end
    end
  end
end