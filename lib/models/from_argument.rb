module FromArgument
  extend ActiveSupport::Concern

  class_methods do
    def from_argument(argument)
      new(argument)
    end

    private

    def error(key, **interps)
      raise Commands::RuntimeError.new("#{i18n_scope}.#{key}", **interps)
    end

    def i18n_scope
      "conversions.#{name.underscore.tr('/', '.')}"
    end
  end
end