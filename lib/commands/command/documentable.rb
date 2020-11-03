module Commands
  class Command
    module Documentable
      extend ActiveSupport::Concern

      USAGE_CACHE_BY_USED_TAG = {}

      class_methods do
        def human_name
          @human_name ||= t('_name', default: tag.humanize)
        end

        def description
          @description ||= t('_description', default: nil)
        end

        def footer
          @footer ||= t('_footer', default: nil)
        end

        def examples
          @examples ||= Examples.build(self)
        end

        def usage(tag = self.tag)
          USAGE_CACHE_BY_USED_TAG[tag] ||= Usage.build(self, tag)
        end
      end

      included do
        delegate :human_name, :usage, :description, :examples, to: :class
      end
    end
  end
end