module Commands
  class CommandsCommand < Command
    register %w[commands commandlist]

    def call
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('title')
        e.desc  = t('desc')

        packages.each do |package_result|
          e.field(package_result.name, build_description(package_result))
        end
      end
    end

    private

    def build_description(package_result)
      channels = format_channels(package_result)
      commands = format_commands(package_result.commands)

      "#{channels}\n#{commands}"
    end

    def format_channels(package_result)
      if package_result.super_global
        return t('super_global')
      end

      channels = package_result.channels

      if channels.size < server.text_channels.size
        ChannelListService.new(server, channels, author)
                          .prefixed(t('enabled'), t('enabled_except'))
      end
    end

    def format_commands(commands)
      commands.map { |command| code(command.tag) }.join(', ')
    end

    def packages
      @packages ||= CommandListService.list(server, author, channel)
    end
  end
end