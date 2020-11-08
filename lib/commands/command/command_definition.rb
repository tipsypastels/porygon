module Commands
  class Command
    module CommandDefinition
      extend ActiveSupport::Concern

      EXAMP_CACHE_BY_USED_TAG = {}
      USAGE_CACHE_BY_USED_TAG = {}

      class_methods do # rubocop:disable Metrics/BlockLength
        attr_reader :tags, :permission, :context
        delegate :name, to: :package, prefix: true

        def register(tags, context: :server, permissions: {})
          @tags       = Array(tags)
          @context    = Context.new(context) 
          @permission = Permissions.new(permissions)

          Commands.register(self)
        end

        def tag
          tags.first
        end

        def alternative_tags
          Array(tags[1..])
        end

        def args(**opts, &block)
          return @args unless block_given?
          @args = Arguments.new(self, **opts, &block)
        end

        def package
          Packages[package_tag]
        end

        def package_tag
          @package_tag ||= begin
            file, = instance_method(:call).source_location 
            file.split('/')[-2]
          end
        end

        def human_name
          t('_name', default: tag.humanize)
        end

        %i[banner desc footer].each do |getter|
          define_method(getter) { t("_#{getter}", default: nil) }
        end

        def examples(tag = self.tag)
          EXAMP_CACHE_BY_USED_TAG[tag] ||= Examples.build(self, tag)
        end

        def usage(tag = self.tag)
          USAGE_CACHE_BY_USED_TAG[tag] ||= Usage.build(self, tag)
        end

        # TODO: remake this
        def listable_for?(_message) 
          true
        end
      end

      included do
        delegate :tags, :tag, :alternative_tags,
                 :human_name, :banner, :usage, :desc, :examples,
                 :package, :package_name, :package_tag,
                 to: :class

        # more generic names that might be used in other contexts, prefix them
        delegate :permission, :context, to: :class, prefix: :command
      end
    end
  end
end