module Commands
  class PollCommand < Command
    self.tag = 'poll'

    

    # self.args = Arguments::Parser.new do |a|
    #   a.arg :values, Resolvers.array_of_strings(3..13, delim: /\s*|\s*/)
    # end

    # self.args = Arguments::SwitchParser.new do |o|
    #   o.format(:with_options, string_delim: /\s*|\s*/) do |a|
    #     a.arg   :question, Resolvers.string
    #     # a.array :options, Resolvers.string, size: 2..10
    #   end
      
    #   o.default do |a|
    #     a.arg :question, Resolvers.string
    #   end
    # end

    def call
      question, *options = args.values
      message = embed do |e|
        e.color  = Porygon::COLORS.info
        e.title  = t('result.title', question: question)
        e.footer = t('result.footer')
      end

      react_to(message, options)
    end

    private

    def react_to(message, options)
      options.each do |option|
        message.react('')
      end
    end
  end
end