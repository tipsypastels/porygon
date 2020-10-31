module Porygon
  class MarkovStore
    def initialize
      @slots = {}

      at_exit { dump_all }
    end

    def dump_all
      @slots.each_value(&:dump)
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
        @dict.generate_2_sentences
      rescue EmptyDictionaryError
        'hi im pory'
      end
    end
  end
end