module Commands
  class ChangelogCommand < Command
    self.tag = 'changelog'

    self.args = Arguments.new(self) do |a|
      a.arg :version, Porygon::Version, default: Porygon::Version.current
    end

    def call
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('title', version: args.version.id)
        e.description = args.version.description
        e.thumbnail   = Porygon::Asset('portrait.png')
        
        if args.version.current?
          e.field(t('recency.title'), t('recency.description'))
        end

        e.field(t('changes'), build_changes)
      end
    end

    private

    def build_changes
      args.version.changes&.map { "• #{_1}" }&.join("\n")
    end
  end
end