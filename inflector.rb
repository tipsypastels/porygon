class Inflector < Zeitwerk::Inflector
  def camelize(basename, abspath)
    if basename =~ /\Aapi(.*)/
      'API' + super($1, abspath)
    else
      super
    end
  end
end