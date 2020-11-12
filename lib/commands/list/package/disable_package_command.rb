module Commands
  class DisablePackageCommand < Command
    register 'disablepackage', permissions: { member: :manage_server }

    args do |a|
      a.arg :packages, Arguments::Array(Packages::Package)
      a.opt :channels, Discordrb::ChannelArray, 
        default: -> cmd { cmd.server.text_channels } 
    end

    def call(packages:, channels:)
      disable_all(packages, channels)
      
      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('removed.title')
        e.desc  = t('removed.desc')
      end
    end
    
    private
    
    def disable_all(packages, channels)
      packages.each do |package|
        no_super_global(package) if package.super_global
        package.disable(channels)
      end
    end

    NO_SUPER_GLOBAL_T = 'conversions.packages/package.no_super_global'

    def no_super_global(package)
      raise UsageError.new(NO_SUPER_GLOBAL_T, arg: package.tag, no_help: true)
    end
  end
end