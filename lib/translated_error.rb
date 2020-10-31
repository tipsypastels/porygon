# A factory for making user-facing error messages that can make use of locales.
# Throw it with a translation key instead of a human readable string.
#
# However, the translation value will *not* be used as the error message itself,
# the key will. That's because in the primary use case (command errors), we want
# to point the key to something that is not a string, such as a translation hash
# for an embed. Error messages cannot contain strings, so we instead throw the
# key and catch it later.
#
# You can get the translated value, which may be a non-string value, using the
# +translated_value+ method. You can also look up keys within it using +key+,
# which is needed for hashes as I18n does not interpolate into a hash result.
module TranslatedError
  # rubocop:disable Metrics/MethodLength
  def self.new(scope, base_class = StandardError)
    Class.new(base_class) do
      attr_reader :interps

      define_method :initialize do |key, **interps|
        super(key)
        @interps = interps
      end

      define_method :translated_value do
        @translated_value ||= I18n.t("#{scope}.#{message}", **@interps)
      end

      define_method :[] do |key, **extra_interps|
        full_key = "#{scope}.#{message}.#{key}"
        I18n.t(full_key, **interps, **extra_interps, default: nil)
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
end