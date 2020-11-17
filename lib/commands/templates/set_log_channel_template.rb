module Commands
  module Templates
    class SetLogChannelTemplate < CommandTemplate
      args do |a|
        a.arg :channel, Discordrb::Channel
      end

      def call(channel:)
        return already_that_channel if already_enabled?(channel)

        enable(channel)
    
        embed do |e|
          e.color = Porygon::COLORS.ok
          e.title = t('done.title')
          e.desc  = t('done.desc', channel: channel.mention)
        end
      end
      
      private

      def already_enabled?(_channel)
        raise NotImplementedError, '#already_enabled? is abstract'
      end

      def enable(_channel)
        raise NotImplementedError, '#enable is abstract'
      end
      
      def already_that_channel
        embed do |e|
          e.color = Porygon::COLORS.warning
          e.title = t('already.title')
          e.desc  = t('already.desc')
        end
      end
    end
  end
end