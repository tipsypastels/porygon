module Commands
  class SetModLogChannelCommand < Templates::SetLogChannelTemplate
    register 'setmodlogchannel', permissions: { member: :manage_server }

    def call(channel:)
      super
    end

    private

    def already_enabled?(channel)
      server.mod_log_channel == channel
    end

    def enable(channel)
      server.mod_log_channel = channel
    end
  end
end