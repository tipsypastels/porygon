module Commands
  class PingCommand < Command
    self.tag = 'ping'
    
    def call
      embed do |e|
        e.color       = Porygon::COLORS.info
        e.thumbnail   = Porygon::Asset('portrait.png')

        e.title       = t('title', version: version)
        e.description = t('description')
      end
    end

    private

    def version
      Porygon::Version.current.full
    end
  end
end