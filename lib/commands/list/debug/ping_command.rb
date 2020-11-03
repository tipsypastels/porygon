module Commands
  class PingCommand < Command
    self.tag = 'ping'
    
    def call
      say t('pong')
    end
  end
end