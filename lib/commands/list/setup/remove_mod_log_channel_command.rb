module Commands
  class RemoveModLogChannelCommand < Templates::RemoveLogChannelTemplate
    register 'removemodlogchannel', permissions: { member: :manage_server }

    def call
      super
    end

    private

    def exist?
      server.mod_log_channel
    end

    def remove
      server.mod_log_channel = nil
    end
  end
end