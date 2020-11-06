module Commands
  module CommandLogger
    class << self
      def used_command(command)
        info command_log(command, 'used_command')
      end

      def runtime_error(command)
        info command_log(command, 'runtime_error')
      end

      def permission_error(command, reason)
        warn command_log(command, 'permission_error', reason: reason)
      end

      def unknown_command(tag, message)
        warn log(message, 'unknown_command', tag)
      end

      def ignored_command(command, ignore_status)
        warn command_log(command, "ignore_#{ignore_status}")
      end

      private

      delegate :info, :warn, to: :"Porygon::LOGGER"
      
      def command_log(command, key, **interps)
        log(command.message, key, command.used_tag, **interps)
      end

      def log(message, key, tag, **interps)
        t key, tag: tag,
               name: message.username,
               location: location_for(message),
               **interps
      end

      def location_for(message)
        if message.server
          t 'location.server', server: message.server_name, 
                               channel: message.channel_name
        else
          t 'location.dm'
        end
      end

      def t(key, **interps)
        I18n.t(key, **interps, scope: 'command_env.logging')
      end
    end
  end
end