module Porygon
  class Changelog
    class << self
      def version_codes
        @version_codes ||= I18n.t('changelog').keys
      end

      def version_exists?(version_code)
        version_code.in? version_codes
      end
    end
  end
end