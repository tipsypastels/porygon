module Porygon
  class MarkovStore
    def initialize
      @slots = {}
    end

    def open(server)
      id = server.resolve_id
      @slots[id] ||= Generator.new(id)
    end

    class Generator
      def initialize(server_id)
        @server_id = server_id
        @dict = MarkyMarkov::Dictionary.new(".markov/#{server_id}")
      end

      def dump
        @dict.save_dictionary!
      end

      def feed(string)
        @dict.parse_string(string)
      end

      def generate
        @dict.generate_1_sentence
      rescue EmptyDictionaryError
        'hi im pory'
      end
    end
  end
end