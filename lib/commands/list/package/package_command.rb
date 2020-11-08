module Commands
  class PackageCommand < Command
    register 'package', permissions: { member: :manage_server }

    args do |a|
      a.arg :package, Packages::Package
    end

    def call(package:)
      embed do |e|
        e.color = Porygon::COLORS.info
        e.thumb = Porygon::PORTRAIT
        e.title = package.name
        e.desc  = package.desc

        e.field(t('commands'), commands(package))
      end
    end

    private

    def commands(package)
      Commands.filter_map { |c| code(c.tag) if c.package == package }.join(', ')
    end
  end
end