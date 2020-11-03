module Commands
  class CommandsCommand < Command
    self.tags = %w[commands commandlist]

    def call
      embed do |e|
        e.color       = Porygon::COLORS.info
        e.title       = t('title')
        e.description = t('description', prefix: Bot.prefix)

        packages.each do |package, commands|
          e.field(package.name, format_commands(commands))
        end
      end
    end

    private

    def packages
      Commands.listable_for(message).group_by(&:package)
    end

    def format_commands(commands)
      commands.map { |command| code(command.tag) }.presence&.join("\n")
    end
  end
end