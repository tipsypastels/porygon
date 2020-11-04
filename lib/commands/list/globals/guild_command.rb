module Commands
  class GuildCommand < Command
    self.tags = %w[guild server]
    self.server_only = true

    def call
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('title')
        e.thumbnail = server.icon_url

        e.inline do
          e.field(t('name'), server.name)
          e.field(t('owner'), owner)
        end
        
        e.field(t('region'), region)

        e.inline do
          e.field(t('members'), server.member_count)
          e.field(t('roles'), server.roles.size)
        end

        e.field(t('emoji'), emoji) if emoji.present?
      end
    end

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