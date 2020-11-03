module Commands
  class Help < Command
    self.tag = 'help'

    self.args = Arguments.new(self) do |a|
      a.arg(:command, Command, optional: true)
    end

    def call
      args.command ? help_with_command : help_info
    end

    private

    def help_with_command
      cmd = args.command

      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('with_command.title', command: cmd.tag)
        e.description = cmd.description

        e.field_row do
          e.field(t('with_command.aliases'), aliases)
          e.field(t('with_command.package'), cmd.package_name)
        end

        e.field(t('with_command.usage'), cmd.usage)
        e.field(t('with_command.examples'), cmd.examples)
      end
    end

    def aliases
      args.command.alternative_tags.map { code(_1) }.join(', ').presence
    end
  end
end