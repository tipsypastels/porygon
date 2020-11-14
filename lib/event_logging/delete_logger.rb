module EventLogging
  class DeleteLogger < EventLogger
    TIME_FORMAT = '`%I:%M:%S %p`'

    attr_reader :channel, :message_id

    def initialize(channel, message_id)
      super(channel.server)

      @channel = channel
      @message_id = message_id
    end

    def log
      return unless server
      return no_cache_fallback unless message
      return if message.from_porygon?

      Bot.stats.missing_deleted_messages.pass!
      embed_deletion_message
    end
    
    private
    
    def embed_deletion_message
      embed do |e|
        e.color  = Porygon::COLORS.info
        e.title  = t('deleted')
        e.footer = t('message_id', id: message.id)
        e.author = message.author
        e.desc   = message.content.presence || t('no_content')
  
        e.field(t('attachments'), attachments)
  
        e.inline do
          e.field(t('channel'), channel.mention)
          e.field(t('sent_at'), message.creation_time.getgm.strftime(TIME_FORMAT))
          e.field(t('deleted_at'), Time.now.getgm.strftime(TIME_FORMAT))
        end
      end
    end

    def no_cache_fallback
      Bot.stats.missing_deleted_messages.fail!

      embed do |e|
        e.color  = Porygon::COLORS.warning
        e.thumb  = Porygon::PORTRAIT
        e.title  = t('deleted')
        e.footer = t('message_id', id: message_id)
        e.desc   = t('not_in_cache')

        e.field(t('channel'), channel.mention)
      end
    end

    def message
      @message ||= Discordrb::Message.cached(message_id)
    end

    def attachments
      message.attachments.each_with_index.map { |attach, i|
        t('attachment', i: i + 1, url: attach.url)
      }.join(', ')
    end
  end
end