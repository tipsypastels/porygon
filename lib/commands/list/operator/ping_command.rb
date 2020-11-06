module Commands
  class PingCommand < Command
    self.tag = 'ping'
    self.allow_dm = true

    def call
      embed do |e|
        e.color       = Porygon::COLORS.info
        e.thumbnail   = Porygon::Asset('portrait.png')

        e.title       = t('title')
        e.footer      = t('footer', version: version)
        e.description = t('description')
      end
    end

    private

    def version
      Porygon::Version.current.id
    end
  end
end