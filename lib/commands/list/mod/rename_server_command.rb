module Commands
  class RenameServerCommand < Command
    self.tags   = %w[renameserver setservername]
    self.access = Permission.manage_server

    args do |a|
      a.arg :name, String
    end

    def call(name:)
      with_bot_permission_handling do
        server.name = name

        embed do |e|
          e.color       = Porygon::COLORS.ok
          e.title       = t('renamed.title')
          e.description = t('renamed.description', name: name)
        end
      end
    end
  end
end