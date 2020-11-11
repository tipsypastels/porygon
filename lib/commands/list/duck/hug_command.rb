module Commands
  class HugCommand < Command
    register 'hug'
    
    args do |a|
      a.arg :hugged, String
    end

    def call(hugged:)
      embed do |e|
        e.color = Porygon::COLORS.ok 
        e.title = t('title', hugged: hugged)
        e.desc  = t('desc', hugged: hugged, stat: stat)
      end
    end

    private

    def stat
      t('stats').sample
    end
  end
end