module Commands
  class RenameChannelCommand < Command
    register %w[renamechannel setchannelname], 
      permissions: { member: :manage_channels, bot: :manage_channels }

    args do |a|
      a.arg :name, String
    end

    def call(name:)
      channel.name = name
      
      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('renamed.title')
        e.desc  = t('renamed.desc', name: channel.mention)
      end
    end
  end
end