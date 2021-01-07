module Discordrb
  class Server
    module Configurable
      def mod_log_channel
        id = settings.mod_log_channel_id
        channel(id) if id
      end

      def mod_log_channel=(channel)
        settings.update(mod_log_channel_id: channel&.resolve_id)
      end

      def warning_log_channel
        id = settings.warning_log_channel_id
        channel(id) if id
      end

      def warning_log_channel=(channel)
        settings.update(warning_log_channel_id: channel&.resolve_id)
      end

      MUTED = 'muted'.freeze

      def muted_role
        if (custom_id = settings.muted_role_id)
          role(custom_id)
        else
          roles.detect { |role| role.name.casecmp(MUTED).zero? }
        end
      end

      def muted_role=(role)
        settings.update(muted_role_id: role&.resolve_id)
      end

      delegate :role_list_url, to: :settings

      def role_list_url=(url)
        url = url.to_s if url.is_a?(URI)
        settings.update(role_list_url: url)
      end

      private

      def settings
        @settings ||= ServerSetting.find_or_create(id: id)
      end
    end
  end
end