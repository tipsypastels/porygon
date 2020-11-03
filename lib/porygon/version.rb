module Porygon
  class Version
    include Comparable

    class << self
      def match
        @match ||= /v?\d+\.\d+\.\d+/
      end

      def current
        @current ||= new(Changelog.version_codes.first)
      end
    end

    attr_reader :full, :major, :minor, :patch

    def initialize(version_code)
      @full = version_code.to_s.delete_prefix('v').tr('-', '.')
      @major, @minor, @patch = @full.split('.')

      # TODO: handle unknown version
      # or invalid input
    end

    def description
      I18n.t("changelog.#{i18n_key}.description", default: nil)
    end

    def changes
      I18n.t("changelog.#{i18n_key}.changes", default: nil)
    end

    def current?
      Version.current == self
    end

    def <=>(other)
      return major <=> other.major unless major == other.major
      return minor <=> other.minor unless minor == other.minor
      return patch <=> other.patch unless patch == other.patch
      0
    rescue ArgumentError
      nil
    end

    def i18n_key
      @i18n_key ||= full.tr('.', '-')
    end
  end
end