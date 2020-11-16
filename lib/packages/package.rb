module Packages
  class Package
    include CommandGroup, Comparable, Documentable, Entryable, ServerLocked

    def self.from_argument(...)
      PackageFinder.find(...)
    end

    attr_reader :tag

    def initialize(tag)
      @tag = tag
      @entries = {}

      warn_if_missing_i18n_entry
    end

    def <=>(other)
      name.casecmp(other.name)
    rescue ArgumentError
      nil
    end
  end
end