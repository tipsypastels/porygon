module Commands
  # A command that prints information about the current guild.
  class Guild < Command
    self.tags = %w[guild guildInfo server serverInfo svr]
    self.server_only = true

    # rubocop:disable Metrics/MethodLength
    def call
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('title')
        e.thumbnail = server.icon_url

        e.field_row do
          e.field(t('name'), server.name)
          e.field(t('owner'), owner)
        end
        
        e.field(t('region'), region)

        e.field_row do
          e.field(t('members'), server.member_count)
          e.field(t('roles'), server.roles.size)
        end

        e.field(t('emoji'), emoji) if emoji.present?
      end
    end
    # rubocop:enable Metrics/MethodLength

    private

    def owner
      server.owner.display_name
    end

    def region
      t("regions.#{server.region_id}", default: :'regions.default')
    end

    def emoji
      @emoji ||= server.emoji.values.join(' ')
    end
  end
end