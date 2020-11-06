module Commands
  class HugCommand < Command
    self.tag = 'hug'
    
    args do |a|
      a.arg :hugged, String
    end

    def call(hugged:)
      embed do |e|
        e.color = Porygon::COLORS.ok 
        e.title = t('title', hugged: hugged)
        e.description = t('description', hugged: hugged, stat: stat)
      end
    end

    private

    def stat
      t('stats').sample
    end
  end
end