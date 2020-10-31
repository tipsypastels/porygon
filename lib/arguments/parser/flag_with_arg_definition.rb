module Arguments
  class Parser
    # A flag that takes one arg. Multiple args are not supported.
    class FlagWithArgDefinition < GenericFlagDefinition
      def needs_arg?
        true
      end

      def to_usage(command)
        if default
          wrap_for_usage("--#{name} #{type_to_usage(command)}=#{default}")
        else
          wrap_for_usage("--#{name} #{type_to_usage(command)}")
        end
      end
    end
  end
end