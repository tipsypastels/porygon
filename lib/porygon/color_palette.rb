module Porygon
  class ColorPalette
    def initialize(filename = 'colors.json')
      @filename = filename
      define_methods
    end

    private

    def define_methods
      parse_json.each { |m, c| self.class.define_method(m) { c } }
    end

    def parse_json
      JSON.parse(read_file).transform_values { |color| color.to_i(16) }
    end

    def read_file
      File.read("assets/#{@filename}")
    end
  end
end