module Packages
  class Package
    attr_reader :tag, :server_ids

    def initialize(tag, server_ids: nil)
      @tag = tag
      @server_ids = server_ids

      Packages::TAGS[tag] = self
    end

    def name
      t(:name)
    end

    def description
      t(:description)
    end

    def server_specific?
      server_ids.present?
    end

    private

    def t(key, **interps)
      I18n.t("packages.#{tag}.#{key}", **interps)
    end
  end
end