module Packages
  class Package
    include Comparable

    attr_reader :tag

    def initialize(tag)
      @tag = tag
      warn_if_missing_i18n_entry
    end

    def name
      t(:name)
    end

    def description
      t(:description)
    end

    def server_ids
      Packages::SERVER_LOCKS[tag]
    end

    def server_specific?
      server_ids.present?
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