module Commands
  class HelpCommand < Command
    register 'help', context: :any

    args do |a|
      a.arg(:command, Command, optional: true)
    end

    def call(command:)
      command ? help_with_command(command) : help_info
    end

    private

    def help_with_command(command)
      embed do |e|
        e.color  = Porygon::COLORS.info
        e.title  = command.human_name
        e.footer = command.footer
        e.desc   = command.desc

        e.inline do
          e.field(t('with_command.command'), code(command.tag))
          e.field(t('with_command.aliases'), build_aliases(command))
          e.field(t('with_command.package'), command.package_name)
        end

        e.field(t('with_command.usage'), command.usage)
        e.field(t('with_command.examples'), command.examples)
      end
    end

    def help_info
      embed do |e|
        e.color  = Porygon::COLORS.info
        e.title  = t('info.title')
        e.footer = t('info.footer')
        e.desc   = t('info.desc', prefix: Bot.prefix)
      end
    end

    def build_aliases(command)
      command.alternative_tags.map { code(_1) }.join(', ').presence
    end
  end
end