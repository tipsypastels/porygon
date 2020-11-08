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
      end
    end

    private

    def version
      Porygon::Version.current.id
    end
  end
end