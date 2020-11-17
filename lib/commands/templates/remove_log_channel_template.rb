module Commands
  module Templates
    class RemoveLogChannelTemplate < CommandTemplate
      def call
        return no_such_channel unless exist?

        remove

        embed do |e|
          e.color = Porygon::COLORS.ok
          e.title = t('done.title')
          e.desc  = t('done.desc')
        end
      end

      private

      def exist?
        raise NotImplementedError, '#exist? is abstract'
      end

      def remove
        raise NotImplementedError, '#remove is abstract'
      end

      def no_such_channel
        embed do |e|
          e.color = Porygon::COLORS.warning
          e.title = t('none.title')
          e.desc  = t('none.desc')
        end
      end
    end
  end
end