module Commands
  class GuildCommand < Command
    register %w[guild server]

    def call
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('title')
        e.thumb = server.icon_url

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
      @emoji ||= EmojiListPresenter.new(server.emoji).join
    end

    class EmojiListPresenter
      MAX = 25

      delegate :size, :present?, to: :@emoji

      def initialize(emoji)
        @emoji = emoji.values
      end

      def join
        emoji_to_show = @emoji.slice(0...MAX)
        out = emoji_to_show.join(', ')
        out += I18n.t('commands.guild.more_emoji', count: size) if present?
        out
      end
    end
    private_constant :EmojiListPresenter
  end
end