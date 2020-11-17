module Commands
  module Templates
    class CommandTemplate < Command
      def self.inherited(mod)
        return if self == CommandTemplate

        # HACK
        # we need to copy the class instance variable
        # from a given template to its implementers
        # instance_variable_set is definitely hacky but
        # i'll use it here rather than implementing an
        # #args= method that i don't actually want
        # to be used in any other context, since
        # args do is the definitive way to do that.
        mod.instance_variable_set(:@args, args.dup_with_subclass(mod)) if args
      end
    end
  end
end