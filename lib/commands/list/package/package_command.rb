module Commands
  class PackageCommand < Command
    register 'package', permissions: { member: :manage_server }

    args do |a|
      a.arg :package, Packages::Package
    end

    def call(package:)
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = package.name
        e.desc  = package.desc

        e.field(t('channels'), channels(package))
        e.field(t('commands'), commands(package))
        
        if package.super_global
          e.field(t('super_global.title'), t('super_global.desc')) 
        end
      end
    end

    private

    def commands(package)
      Commands.filter_map { |c| code(c.tag) if c.package == package }.join(', ')
    end

    def channels(package)
      channels = package.channels(server)
      
      if channels.size == server.text_channels.size
        return t('all_channels')
      end
      
      channels.map(&:mention).join(', ').presence
    end
  end
end