class PackageChangeSummaryService
  class GenericChangeObject
    attr_reader :package, :server, :member, :channels
    delegate :name, to: :package

    def initialize(package, server, member, channels)
      @package  = package
      @server   = server
      @member   = member
      @channels = channels
    end

    def summary
      summarize
      @stats.join("\n")
    end

    private

    def all_channels?
      channels.size == server.text_channels.size
    end

    def currently_enabled_channels
      package.channels(server)
    end

    def currently_enabled_channel_ids
      currently_enabled_channels.collect(&:id).to_set
    end

    def stat(key, **interps)
      @stats ||= []
      @stats << t(key, **interps)
    end

    def to_list(channels)
      channels.collect(&:mention).join(', ')
    end

    def to_smart_list(channels)
      ChannelListService.new(server, channels, member)
                        .prefixed(t('in'), t('in_except'))
    end
  end
end