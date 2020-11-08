module Commands
  class VersionCommand < Command
    register 'version'

    def call
      embed do |e|
        e.color = Porygon::COLORS.info
        e.thumb = Porygon::PORTRAIT
        e.title = t('title', version: version)
        e.desc  = t('desc', version: version)
      end
    end

    private

    def version
      Porygon::Version.current.id
    end
  end
end