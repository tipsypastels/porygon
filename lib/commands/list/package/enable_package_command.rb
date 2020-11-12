module Commands
  class EnablePackageCommand < Command
    register %w[enablepackage enablepackages epkg], 
      permissions: { member: :manage_server }

    args do |a|
      a.arg :packages, Arguments::Array(Packages::Package)
      a.opt :channels, Discordrb::ChannelArray, 
        default: -> cmd { cmd.server.text_channels }
    end

    def call(packages:, channels:)
      
      # is_all = channels.size == server.text_channels.size
      
      embed do |e|
        e.color  = Porygon::COLORS.ok
        e.title  = t('added.title')
        e.footer = t('added.footer')

        summary(packages, channels).into_embed(e)
      end

      enable_all(packages, channels)
    end

    private

    def summary(packages, channels)
      PackageChangeSummaryService.new server, 
                                      author, 
                                      packages, 
                                      channels, 
                                      action: :enabled
    end

    def enable_all(packages, channels)
      packages.each do |package|
        no_super_global(package) if package.super_global
        package.enable(channels)
      end
    end

    NO_SUPER_GLOBAL_T = 'conversions.packages/package.no_super_global'

    def no_super_global(package)
      raise UsageError.new(NO_SUPER_GLOBAL_T, arg: package.tag, no_help: true)
    end
  end
end