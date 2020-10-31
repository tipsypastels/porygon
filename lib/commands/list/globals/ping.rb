module Commands
  # A simple ping command.
  class Ping < Command
    self.tag = 'ping'
    
    def call
      say t('pong')
    end
  end
end