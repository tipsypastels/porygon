module Packages
  class GlobalPackage < Package
    def enabled?(*)
      true
    end

    def enable
      # no-op
    end

    def disable
      raise Errors::GlobalError, self
    end
  end
end