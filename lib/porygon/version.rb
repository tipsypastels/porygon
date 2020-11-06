module Porygon
  class Version
    include Comparable

    class << self
      def current
        @current ||= new(ids.first)
      end

      def ids
        @ids ||= I18n.t('changelog').keys.map { |sym| sym.to_s.to_i }
      end

      def exist?(id)
        id.in? ids
      end

      def from_argument(error, arg, *)
        arg.sub!(/^[v#]/, '')
        code = Integer(arg) rescue error[:malformed, version: arg]

        unless exist?(code)
          return error[:nonexistant, version: code, current: current.id]
        end
         
        new(code)
      end
    end

    attr_reader :id
    delegate :<=>, to: :id

    def initialize(id)
      @id = id
    end

    def description
      I18n.t("changelog.#{id}.description", default: nil)
    end

    def changes
      I18n.t("changelog.#{id}.changes", default: nil)
    end

    def current?
      Version.current == self
    end
  end
end