module Commands
  class OpStatsCommand < Command
    include ActionView::Helpers::DateHelper

    register 'opstats', permissions: { owner: true }
    
    def call
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('title')

        e.field(t('servers'), Bot.servers.size)
        e.field(t('uptime'), uptime)

        e.field(t('cached_members'), cached_members)

        e.field(t('cached_messages'), cached_messages)
        e.field(t('del_missing_percent'), del_missing_percent)
      end
    end

    private

    def uptime
      distance_of_time_in_words(Bot.start_time, Time.now)
    end

    def cached_messages
      Discordrb::Message::CachedMessage.count
    end

    def cached_members
      Porygon::MemberJoinList::MemberJoinDate.count
    end

    def del_missing_percent
      Bot.stats.missing_deleted_messages_percent.to_s
    end
  end
end