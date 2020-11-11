module Commands
  class NudgeCommand < Command
    register 'nudge'

    def call
      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = disaster
        e.desc  = t('killed', members: members)
      end
    end

    private

    def disaster
      t('disasters').sample
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