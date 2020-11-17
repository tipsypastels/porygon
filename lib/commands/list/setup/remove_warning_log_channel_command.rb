module Commands
  class RemoveWarningLogChannelCommand < Templates::RemoveLogChannelTemplate
    register 'removewarninglogchannel', permissions: { member: :manage_server }

    def call
      super
    end

    private

    def exist?
      server.warning_log_channel
    end

    def remove
      server.warning_log_channel = nil
    end
  end
end