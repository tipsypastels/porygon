module Packages
  class Package
    class EnabledPackage < Sequel::Model
      def self.for(package, server)
        where(tag: package.tag, server_id: server.id).first
      end

      delegate :include?, to: :channels

      def channels
        @channels ||= channels_factory.new(channel_ids)
      end

      def channels=(channels)
        self.channel_ids =
          case channels
          when Array, Set
            channels.collect(&:resolve_id).join(',')
          else
            channels
          end
      end

      def enable(new_channels)
        @channels.push(new_channels)
        
        update(channels: @channels)
      end
      
      private

      def channels_factory
        channel_ids.nil? ? SetOfAllChannels : SetOfSomeChannels
      end
    end
  end
end