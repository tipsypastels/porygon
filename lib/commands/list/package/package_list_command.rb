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
      "- #{channels.map(&:mention).join(', ')}"
    end

    def enabled
      packages[0]
    end

    def disabled
      packages[1]
    end

    def packages
      @packages ||= 
        Packages.select { |pkg| include_package?(pkg) }
                .partition { |pkg| pkg.enabled_in_at_least_one_channel?(server, author) }
    end

    def include_package?(package)
      return unless package.supports?(server)
      return package.super_global.call(author) if package.super_global

      true
    end
  end
end