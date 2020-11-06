module Discordrb
  class Server

    def find_role(name)
      if name =~ Role::MENTION_FORMAT
        role($1)
      else
        find_role_by_query(name)
      end
    end

    def find_role_by_query(name)
      roles.detect { |role| role.name.casecmp(name).zero? }
    end

    def find_text_channel(name)
      if name =~ Channel::MENTION_FORMAT
        channel($1.to_i)
      else
        text_channels.detect { |chan| chan.name.casecmp(name).zero? }
      end
    end

    def channel(id)
      text_channels.detect { |chan| chan.id == id }
    end

    def settings
      @settings ||= ServerSetting.find_or_create(id: id)
    end

    def mod_log_channel
      id = settings.mod_log_channel_id
      channel(id) if id
    end

    def mod_log_channel=(channel)
      settings.update(mod_log_channel_id: channel&.id)
    end
  end
end