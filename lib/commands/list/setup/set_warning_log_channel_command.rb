module Commands
  class SetWarningLogChannelCommand < Templates::SetLogChannelTemplate
    register 'setwarninglogchannel', permissions: { member: :manage_server }

    def call(channel:)
      super
    end

    private

    def already_enabled?(channel)
      server.warning_log_channel == channel
    end

    def enable(channel)
      server.warning_log_channel = channel
    end
  end
end