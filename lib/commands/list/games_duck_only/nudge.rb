module Commands
  class Nudge < Command
    self.tag         = 'nudge'
    self.server_only = true

    def call
      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = disaster
        e.description = "#{members} were killed."
      end
    end

    private

    DISASTERS = [
      'Buildings crumble',
      'Earthquakes make their way downtown, ziggin fast',
      'Cookies crumble',
      'Groudon: Emerges',
      'A Porytude 7 earthquake!',
      'Just imagine Discord shaking',
      'Cars tumble down the roads',
      'Earthquakes are uncomf',
      'Hundreds of books drop from the shelves',
      'All the chairs roll away',
      'Vases fall and shatter',
      'A glass of water spills',
      'A plant falls over, leaving dirt everywhere',
      'Random ceiling tiles fall down',
      'The floor shakes and cracks',
    ]

    def disaster
      DISASTERS.sample
    end

    def members
      count = [server.member_count, base_count].min
      server.members.sample(count).map(&:display_name).to_sentence
    end

    def base_count
      rand(3..7)
    end
  end
end