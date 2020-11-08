module Packages
  class Package
    def self.from_argument(...)
      PackageFinder.find(...)
    end

    include Comparable

    attr_reader :tag

    def initialize(tag)
      @tag = tag
      warn_if_missing_i18n_entry
    end

    def name
      t(:name)
    end

    def desc
      t(:desc)
    end

    def server_ids
      Packages::SERVER_LOCKS[tag]
    end

    def server_specific?
      server_ids.present?
    end

    def supports?(server)
      return true unless server_specific?
      server.resolve_id.in? server_ids
    end

    def <=>(other)
      name.casecmp(other.name)
    rescue ArgumentError
      nil
    end

    private

    def warn_if_missing_i18n_entry
      t(:name, default: false) || 
        Porygon::LOGGER.warn("Package \"#{tag}\" has no language file entry!")
    end

    def t(key, **interps)
      I18n.t("packages.#{tag}.#{key}", **interps)
    end
  end
end