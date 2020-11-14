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
        
        e.field(t('join_cache_size'), join_cache_size)
        
        e.field(t('message_cache_size'), message_cache_size)
        e.field(t('del_missing_percent'), del_missing_percent)
      end
    end
    
    private
    
    delegate :stats, to: :Bot
    delegate :join_cache_size, :message_cache_size, to: :stats

    def uptime
      stats.start_time.ago_in_words
    end

    def del_missing_percent
      stats.missing_deleted_messages_percent
    end
  end
end