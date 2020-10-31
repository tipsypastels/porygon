module Commands
  module Registrable
    def register_all
      Command.subclasses.each { |command| register(command) }
    end

    def register(command)
      validate(command)

      ALL << command
      command.tags.each { |tag| TAGS[tag] = command }
    end

    private

    def validate(command)
      validate_tag_presence(command)
      validate_package_presence(command)
    end

    def validate_tag_presence(command)
      return unless command.tags.empty?
      raise StaticError.new('missing_tags', command: command)
    end

    def validate_package_presence(command)
      return if command.package
      raise StaticError.new 'invalid_package', 
                            command: command, 
                            package: command.package_tag
    end
  end
end