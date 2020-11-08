module Commands
  class RenameServerCommand < Command
    register %w[renameserver setservername],
      permissions: { member: :manage_server, bot: :manage_server }

    args do |a|
      a.arg :name, String
    end

    def call(name:)
      server.name = name

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('renamed.title')
        e.desc  = t('renamed.desc', name: name)
      end
    end
  end
end