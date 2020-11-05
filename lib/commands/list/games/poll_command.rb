module Commands
  class PollCommand < Command    
    self.tag = 'poll'

    self.args = Arguments.new(self, split: :never) do |a|    
      a.arg :poll, Poll
    end

    LETTERS = t('letters')
    BOOLS   = t('bools')

    delegate :poll, to: :args

    def call
      message = embed do |e|
        e.color       = Porygon::COLORS.ok
        e.title       = t('result.title', question: poll.question)
        e.footer      = t('result.footer')
        e.description = description
      end

      react_to(message)
    end

    private

    def description
      poll.map { |opt, i| "#{LETTERS[i]} #{opt.humanize}" }&.join("\n")
    end

    def react_to(message)
      emotes.each do |emote|
        message.react(emote)
      end
    end

    def emotes
      poll.boolean? ? BOOLS : LETTERS.slice(0...poll.size)
    end
  end
end