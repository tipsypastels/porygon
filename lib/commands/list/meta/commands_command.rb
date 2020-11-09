module Commands
  class CommandsCommand < Command
    register %w[commands commandlist]

    def call
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('title')
        e.desc  = t('desc')

        packages.each do |package, commands|
          e.field(package.name, build_description(package, commands))
        end
      end
    end

    private

    def build_description(package, commands)
      "#{enabled_channels(package)}\n#{format_commands(commands)}"
    end

    def enabled_channels(package)
      return unless server

      channels = package.channels(server)

      if package.super_global
        return t('super_global')
      end

      if channels.size < server.text_channels.size
        ChannelListService.list(server, channels, t('enabled'), t('enabled_except'))
      end
    end

    def format_commands(commands)
      commands.map { |command| code(command.tag) }.presence.join(', ') if commands
    end

    def packages
      @packages ||= Packages.filter_map do |package|
        next unless package.supports?(server)
        next unless package.enabled_in_at_least_one_channel?(server, author)
        
        commands = package.commands.select do |command|
          Permissions::Checker.valid?(command.permission, self, silent: true)
        end

        [package, commands.presence]
      end
    end
  end
end