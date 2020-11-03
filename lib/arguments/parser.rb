class Arguments
  class Parser < Porygon::Internals::OptionParser
    def initialize
      super(nil, 32, ' ')
      @added_first_opt = false

      self.program_name = ''
      accept(Commands::Command) { |tag| Commands::TAGS[tag] }
    end

    def opt(short, long, value, type, desc)
      add_opt_existance_to_banner

      if type
        on("-#{short}", "--#{long} #{value}", type, desc)
      else
        on("-#{short}", "--#{long}", desc)
      end
    end

    private

    def add_opt_existance_to_banner
      @banner += " #{I18n.t('command_env.has_options')}" unless @added_first_opt
      @added_first_opt = true
    end
  end
end