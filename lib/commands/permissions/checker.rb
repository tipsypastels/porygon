module Commands
  class Permissions
    class Checker
      include Porygon.i18n_scope('command_env.logging.permission_error_reasons')

      def self.check(...)
        new(...).check
      end

      attr_reader :command
      delegate :server, :author, :channel, to: :command

      def initialize(command)
        @command = command
      end

      def check
        CommandAccessService
          .new(author, channel, command)
          .on(:member_lacks_permission, method(:on_member_lacks_permission))
          .on(:bot_lacks_permission, method(:on_bot_lacks_permission))
          .on(:not_bot_owner, method(:on_not_bot_owner))
          .check_all
      end

      private

      def on_member_lacks_permission(permission)
        permission_error('lacks_permission', permission: permission)
      end

      def on_bot_lacks_permission(permission)
        embed do |e|
          e.color = Porygon::COLORS.error
          e.thumb = Porygon::PORTRAIT
          e.title = I18n.t('command_env.errors.bot_perm.title')
          e.desc  = I18n.t('command_env.errors.bot_perm.desc', perm: permission)
        end
      end

      def on_not_bot_owner
        permission_error('not_bot_owner')
      end

      def permission_error(error_key, **interps)
        error = t(error_key, **interps)
        CommandLogger.permission_error(command, error)
      end

      def embed(&block)
        command.embed(&block)
      end
    end
  end
end