module Commands
  class Help < Command
    self.tag = 'help'

    self.args = Arguments::SwitchParser.new do |f|
      f.format(:command_list) do |a|
        a.arg :keyword, Resolvers.keyword('commands')
      end

      f.format(:command_help) do |a|
        a.arg :command, Resolvers.command
      end

      f.default
    end

    def call_command_list
      p 'command list'
    end

    def call_command_help
      p 'command help'
    end
    
    def call
      p 'help'
    end
  end
end