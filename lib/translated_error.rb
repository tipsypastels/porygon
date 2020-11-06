module TranslatedError
  def self.new(scope, base_class = StandardError)
    Class.new(base_class) do
      define_method :initialize do |key, **interps|
        super I18n.t(key, **interps, scope: scope)
      end
    end
  end
end