module Commands
  class PollCommand < Command    
    self.tag = 'poll'

    args split: :never do |a|    
      a.arg :poll, Poll
    end

    LETTERS = t('letters')
    BOOLS   = t('bools')

    def call(poll:)
      message = embed do |e|
        e.color       = Porygon::COLORS.ok
        e.title       = t('result.title', question: poll.question)
        e.footer      = t('result.footer')
        e.description = describe(poll)
      end

      react_to(message, poll)
    end

    private

    def describe(poll)
      poll.map { |opt, i| "#{LETTERS[i]} #{opt.humanize}" }&.join("\n")
    end

    def react_to(message, poll)
      emotes_for(poll).each do |emote|
        message.react(emote)
      end
    end

    def emotes_for(poll)
      poll.boolean? ? BOOLS : LETTERS.slice(0...poll.size)
    end
  end
end