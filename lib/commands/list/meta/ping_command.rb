module Commands
  class PingCommand < Command
    include ActionView::Helpers::DateHelper

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

    def version
      Porygon::Version.current.id
    end

    def uptime
      distance_of_time_in_words(Bot.start_time, Time.now)
    end
  end
end