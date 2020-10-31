module Commands
  class Pory < Command
    self.tag  = 'pory'
    self.args = Arguments::Plain.new(:text)

    def call
      markov = Bot.markov.open(server)
      markov.feed(args) if args.present?

      say markov.generate
    end
  end
end