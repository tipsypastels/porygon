module Commands
  class ChangelogCommand < Command
    self.tag = 'changelog'

    args do |a|
      a.arg :version, Porygon::Version, default: Porygon::Version.current
    end

    def call(version:)
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('title', version: version.id)
        e.description = version.description
        e.thumbnail   = Porygon::Asset('portrait.png')
        
        if version.current?
          e.field(t('recency.title'), t('recency.description'))
        end

        e.field(t('changes'), build_changes(version))
      end
    end

    private

    def build_changes(version)
      version.changes&.map { "• #{_1}" }&.join("\n")
    end
  end
end