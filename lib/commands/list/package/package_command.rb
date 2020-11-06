module Commands
  class PackageCommand < Command
    self.tag    = 'package'
    self.access = Permission.manage_server

    args do |a|
      a.arg :package, Packages::Package
    end

    def call(package:)
      embed do |e|
        e.color       = Porygon::COLORS.info
        e.title       = package.name
        e.thumbnail   = Porygon::Asset('portrait.png')
        e.description = package.description

        e.field(t('commands'), commands(package))
      end
    end

    private

    def commands(package)
      Commands.filter_map { |c| code(c.tag) if c.package == package }.join(', ')
    end
  end
end