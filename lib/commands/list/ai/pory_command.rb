module Commands
  class PoryCommand < Command
    self.tag = 'pory'
    
    args split: :spaces do |a|
      a.arg :message, String, optional: true
    end

    def call(message:)
      markov = Bot.markov.open(server)
      markov.feed(message) if message.present?

      say markov.generate

      markov.dump
    end
  end
end