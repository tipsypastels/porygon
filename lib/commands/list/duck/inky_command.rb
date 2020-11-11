module Commands
  class InkyCommand < Command
    register 'inky'
    
    MESSAGES = t('messages')

    def call
      say MESSAGES.sample
    end
  end
end