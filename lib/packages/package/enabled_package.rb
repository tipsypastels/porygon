module Packages
  class Package
    class EnabledPackage < Sequel::Model
      class << self
        def enable(tag, channels)
          channels.each do |channel|
            find_or_create tag: tag, 
                           server_id: channel.server.id, 
                           channel_id: channel.id
          end
        end

        def disable(tag, channels)
          server_id   = channels.first.server.id
          channel_ids = channels.collect(&:id)

          where(tag: tag, channel_id: channel_ids).destroy
          cache[[server_id, tag]]&.except!(*channel_ids)
        end

        def enabled_in_at_least_one_channel?(tag, server)
          cache[[server.id, tag]].present?
        end

        def enabled_channels(tag, server)
          (cache[[server.id, tag]] || []).map { |cid,| server.channel(cid) }
                                         .compact
        end

        def enabled?(channel, tag)
          cache[[channel.server.id, tag]]&.[](channel.id)
        end

        def cache
          @cache ||= 
            {}.tap do |cache|
              each do |entry|
                key = [entry.server_id, entry.tag]
                cache[key] ||= {}
                cache[key][entry.channel_id] = true
              end
            end
        end
      end

      def after_create
        self.class.cache[[server_id, tag]] ||= {}
        self.class.cache[[server_id, tag]][channel_id] = true
      end

      def after_destoy
        self.class.cache[server_id, tag]&.delete(channel_id)
      end
    end
  end
end