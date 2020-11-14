module Commands
  class PingCommand < Command
    register 'ping'

    def call
      embed do |e|
        e.color  = Porygon::COLORS.info
        e.thumb  = Porygon::PORTRAIT
        e.title  = t('title')
        e.footer = t('footer', version: version)
        e.desc   = t('desc')

        e.field(t('uptime'), uptime)
      end
    end

    private

    delegate :stats, to: :Bot

    def version
      Porygon::Version.current.id
    end

    def uptime
      stats.start_time.ago_in_words
    end
  end
end