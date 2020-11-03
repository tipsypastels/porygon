module Commands
  class Command
    module Listable
      extend ActiveSupport::Concern

      class_methods do
        def listable_for?(message)
          return false if access && !access.call(message)
          
          true
        end
      end
    end
  end
end