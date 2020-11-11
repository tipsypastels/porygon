module Commands
  class ThanosCommand < Command
    register 'thanos'

    COLORS = {
      spare: Porygon::COLORS.ok,
      kill:  Porygon::COLORS.error,
    }

    def call
      embed do |e|
        e.color = COLORS[result]
        e.title = t("#{result}.title")
        e.desc  = t("#{result}.desc")
        e.thumb = Porygon::Asset("thanos/#{result}.jpeg")
      end
    end

    private

    def result
      @result ||= spare? ? :spare : :kill
    end

    def spare?
      srand(message.author.id)
      rand.round.zero?
    end
  end
end