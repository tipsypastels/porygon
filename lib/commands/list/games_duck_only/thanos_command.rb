module Commands
  class ThanosCommand < Command
    self.tag = 'thanos'

    COLORS = {
      spare: Porygon::COLORS.ok,
      kill:  Porygon::COLORS.error,
    }

    def call
      embed do |e|
        e.color       = COLORS[result]
        e.title       = t("#{result}.title")
        e.description = t("#{result}.description")
        e.thumbnail   = Porygon::Asset("thanos/#{result}.png")
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