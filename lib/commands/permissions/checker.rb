module Commands
  class Permissions
    class Checker
      include Porygon.i18n_scope('command_env.logging.permission_error_reasons')

      def self.valid?(...)
        new(...).valid?
      end

      attr_reader :perms, :command, :silent
      delegate :server, :author, :channel, to: :command
      delegate :bot_perms, :member_perms, to: :perms

      def initialize(perms, command, silent:)
        @perms   = perms
        @command = command
        @silent  = silent
      end

      def valid?
        return false unless member_perms_valid?
        return false unless bot_perms_valid?
        return false unless owner_only_valid?

        true
      end

      private

      def member_perms_valid?
        return member_perms.empty? unless server
        return true if author_is_owner?

        missing = member_perms.find { |perm| !perm?(author, perm) }
        
        if missing
          permission_error('lacks_permission', permission: missing)
          return false
        end

        true
      end

      def bot_perms_valid?
        return bot_perms.empty? unless server

        bot = server.member(Bot.user_id)
        missing = bot_perms.find { |perm| !perm?(bot, perm) }

        if missing
          embed do |e|
            e.color = Porygon::COLORS.error
            e.thumb = Porygon::PORTRAIT
            e.title = I18n.t('command_env.errors.bot_perm.title')
            e.desc  = I18n.t('command_env.errors.bot_perm.desc', perm: missing)
          end

          return false
        end

        true
      end

      def owner_only_valid?
        if perms.owner_only? && !author_is_owner?
          permission_error('not_bot_owner')
          return false
        end

        true
      end

      def perm?(member, perm)
        member.permission?(perm, channel)
      end

      def author_is_owner?
        Bot.owner?(author)
      end

      def permission_error(error_key, **interps)
        return if silent

        error = t(error_key, **interps)
        CommandLogger.permission_error(command, error)
      end

      def embed(&block)
        command.embed(&block) unless silent
      end
    end
  end
end