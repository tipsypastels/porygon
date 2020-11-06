class Inflector < Zeitwerk::Inflector
  def camelize(basename, abspath)
    if basename =~ /\Aapi(.*)/
      'API' + super($1, abspath)
    elsif basename =~ /(.*)rgb\z/
      super($1, abspath) + 'RGB'
    else
      super
    end
  end
end