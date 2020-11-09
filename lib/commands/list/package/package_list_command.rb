module Commands
  class PackageListCommand < Command
    register 'packagelist', permissions: { member: :manage_server }

    def call
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('title')
        e.desc  = t('desc')

        if enabled.present?
          e.field(t('on_this_server'), render_list(enabled))
        end

        if disabled.present?
          e.field(t('off_this_server'), render_list(disabled))
        end
      end
    end

    private

    def render_list(list)
      list.map { |package| 
        "• #{package.name} (`#{package.tag}`) #{render_channels(package)}" 
      }.join("\n")
    end

    def render_channels(package)
      channels = package.channels(server)

      return if channels.empty? || channels.size == server.text_channels.size
      ChannelListService.list(server, channels, t('enabled'), t('enabled_except'))
    end

    def enabled
      packages[0]
    end

    def disabled
      packages[1]
    end

    def packages
      @packages ||= 
        Packages.select(&method(:include_package?))
                .partition(&method(:enabled_package?))
    end

    def include_package?(package)
      return unless package.supports?(server)
      return package.super_global.call(author) if package.super_global

      true
    end

    def enabled_package?(package)
      package.enabled_in_at_least_one_channel?(server, author)
    end
  end
end