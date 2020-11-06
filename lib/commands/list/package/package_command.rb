module Commands
  class PackageCommand < Command
    self.tag    = 'package'
    self.access = Permission.manage_server

    args do |a|
      a.arg :package, Packages::Package
    end

    def call(package:)
      p package
    end
  end
end