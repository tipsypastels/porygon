module Commands
  class Help < Command
    self.tag = 'help'

    self.args = Arguments::SwitchParser.new do |f|
      f.format(:command_list) do |a|
        a.arg :keyword, KeywordResolver['commands']
      end

      f.format(:command_help) do |a|
        a.arg :command, CommandResolver
      end

      f.format(:package_help) do |a|
        a.flag :package, PackageResolver
      end

      f.default
    end

    def call_command_list
      p 'command list'
    end

    def call_command_help
      p 'command help'
    end

    def call_package_help
      p 'package help'
    end
    
    def call
      p 'help'
    end
  end
end