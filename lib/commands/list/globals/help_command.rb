module Commands
  class HelpCommand < Command
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
        e.color       = Porygon::COLORS.info
        e.title       = cmd.human_name
        e.footer      = cmd.footer
        e.description = cmd.description

        e.inline do
          e.field(t('with_command.command'), code(cmd.tag))
          e.field(t('with_command.aliases'), build_aliases(cmd))
          e.field(t('with_command.package'), cmd.package_name)
        end

        e.field(t('with_command.usage'), cmd.usage)
        e.field(t('with_command.examples'), cmd.examples)
      end
    end

    def help_info
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title       = t('info.title')
        e.footer      = t('info.footer')
        e.description = t('info.description', prefix: Bot.prefix)
      end
    end

    def build_aliases(cmd)
      cmd.alternative_tags.map { code(_1) }.join(', ').presence
    end
  end
end