module Commands
  class Command
    module Taggable
      extend ActiveSupport::Concern

      class_methods do
        attr_reader :tag
        attr_reader :alternative_tags

        def tags
          [tag, *alternative_tags]
        end

        private

        def tag=(tag)
          @tag = tag
          @alternative_tags = []
        end

        def tags=(tags)
          @tag, *@alternative_tags = Array(tags)
        end
      end

      included do
        delegate :tag, :tags, :alternative_tags, to: :class
      end
    end
  end
end