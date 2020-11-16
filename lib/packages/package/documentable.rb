module Packages
  class Package
    module Documentable
      def name
        t(:name)
      end

      def desc
        t(:desc)
      end

      private

      def warn_if_missing_i18n_entry
        unless t(:name, default: false) 
          Porygon::LOGGER.warn("Package \"#{tag}\" has no language file entry!")
        end
      end

      def t(key, **interps)
        I18n.t("packages.#{tag}.#{key}", **interps)
      end
    end
  end
end