module Commands
  class Command
    module Packaged
      extend ActiveSupport::Concern
      
      class_methods do
        delegate :name, to: :package, prefix: true

        def package
          Packages::TAGS[package_tag]
        end

        def package_tag
          @package_tag ||= begin
            file, = instance_method(:call).source_location 
            file.split('/')[-2]
          end
        end
      end

      included do
        delegate :package, :package_name, :package_tag, to: :class
      end
    end
  end
end