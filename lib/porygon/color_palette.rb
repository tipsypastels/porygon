module Porygon
  class ColorPalette
    def initialize(filename = 'colors.json')
      @filename = filename
      define_methods
    end

    private

    def define_methods
      json.each { |m, c| self.class.define_method(m) { c } }
    end

    def json
      JSON.parse(read_file).transform_values { |color| Color.from_s(color) }
    end

    def read_file
      File.read("assets/#{@filename}")
    end
  end
end