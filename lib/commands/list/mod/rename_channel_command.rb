module Commands
  class RenameChannelCommand < Command
    self.tags   = %w[renamechannel setchannelname]
    self.access = Permission.manage_channels

    self.args = Arguments.new(self) do |a|
      a.arg :name, String
    end

    def call
      with_bot_permission_handling do
        channel.name = args.name
        
        embed do |e|
          e.color       = Porygon::COLORS.ok
          e.title       = t('renamed.title')
          e.description = t('renamed.description', name: channel.mention)
        end
      end
    end
  end
end