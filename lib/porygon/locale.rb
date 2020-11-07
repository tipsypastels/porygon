module Porygon
  class Locale
    using Refinements::RecursiveMap

    def self.load_file(language)
      YAML.load_file("./locales/#{language}.yml")
          .recursive_map { |line| Node.new(line) }
    end

    attr_reader :language
    delegate :load_file, to: :class

    def initialize(language = :en)
      self.language = language
    end
    
    def language=(language)
      @language = language.to_s
      @data = load_file(language)
    end

    def [](key, **interps)
      @data.dig(language, *key.split('.'))
    end

    Node = Struct.new(:line) do
      
    end
  end
end