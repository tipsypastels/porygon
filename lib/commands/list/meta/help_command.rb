module Commands
  class HelpCommand < Command
    register 'help'

    args do |a|
      a.arg(:command, Command, optional: true)
    end

    def call(command:)
      command ? help_with_command(command) : help_info
    end

    private

    def help_with_command(command)
      check_command_is_usable_and_enabled(command)

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
        e.thumb  = Porygon::PORTRAIT
        e.title  = t('info.title')
        e.desc   = t('info.desc', prefix: Bot.prefix)
        e.footer = { text: t('info.footer'), icon_url: Bot.owner_avatar }
      end
    end

    def build_aliases(command)
      command.alternative_tags.map { code(_1) }.join(', ').presence
    end

    def check_command_is_usable_and_enabled(command)
      unless command_is_usable_and_enabled?(command)
        raise UsageError.new('conversions.commands/command.nonexistant', arg: raw_args)
      end
    end

    # TODO: this is ugly. unify this into one service that's used across the board
    def command_is_usable_and_enabled?(command)
      package = command.package
      
      package.supports?(server) && 
        package.enabled?(channel, author) &&
        Permissions::Checker.valid?(command.permission, self, silent: true) 
    end
  end
end