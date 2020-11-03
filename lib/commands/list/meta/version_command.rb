module Commands
  class VersionCommand < Command
    self.tag = 'version'

    def call
      embed do |e|
        e.color       = Porygon::COLORS.info
        e.title       = t('title', version: version)
        e.thumbnail   = Porygon::Asset('portrait.png')
        e.description = t('description', version: version)
      end
    end

    private

    def version
      Porygon::Version.current.full
    end
  end
end