module Commands
  class PoryCommand < Command
    self.tag = 'pory'
    
    self.args = Arguments.new(self) do |a|
      a.arg :message, String, optional: true
    end

    def call
      markov = Bot.markov.open(server)
      markov.feed(args.message) if args.message.present?

      say markov.generate

      markov.dump
    end
  end
end