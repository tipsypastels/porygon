module Commands
  class Command
    module Documentable
      extend ActiveSupport::Concern

      USAGE_CACHE_BY_USED_TAG = {}

      class_methods do
        def examples=(raw_examples)
          @raw_examples = raw_examples
        end

        def examples(tag = self.tag)
          return unless @raw_examples


        end

        def usage(tag = self.tag)
          USAGE_CACHE_BY_USED_TAG[tag] ||= begin
            (@args_usage ||= Array(args.usage(self))).map do |usage|
              [Bot.prefix + tag, usage].join(' ')
            end.join("\n")
          end
        end
      end

      included do
        delegate :usage, to: :class
      end
    end
  end
end