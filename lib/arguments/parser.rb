class Arguments
  class Parser < Porygon::Internals::OptionParser
    def initialize
      super(nil, 32, ' ')
      @added_first_opt = false

      self.program_name = ''
      add_accepts
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

    def add_accepts
      accept(Commands::Command) { |tag| Commands::TAGS[tag] }
      accept_matcher(Equation)
    end

    def add_opt_existance_to_banner
      return if @added_first_opt
      
      self.banner += " #{I18n.t('command_env.has_options')}"
      @added_first_opt = true
    end
  end
end