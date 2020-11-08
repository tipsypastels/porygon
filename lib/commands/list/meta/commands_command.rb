module Commands
  class CommandsCommand < Command
    register %w[commands commandlist], context: :any

    def call
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('title')
        e.desc  = t('desc')

        packages.sort.each do |package, commands|
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