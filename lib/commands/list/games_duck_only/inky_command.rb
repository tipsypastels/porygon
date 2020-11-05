module Commands
  class InkyCommand < Command
    self.tag = 'inky'
    
    MESSAGES = t('messages')

    def call
      say MESSAGES.sample
    end
  end
end