module Commands
  class HugCommand < Command
    self.tag  = 'hug'
    self.args = Arguments.new(self) do |a|
      a.arg :hugged, String
    end

    def call
      embed do |e|
        e.color = Porygon::COLORS.ok 
        e.title = t('title', hugged: args.hugged)
        e.description = t('description', hugged: args.hugged, stat: stat)
      end
    end

    private

    def stat
      t('stats').sample
    end
  end
end