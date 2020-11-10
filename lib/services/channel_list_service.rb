class ChannelListService
  ChannelsResult = Struct.new(:type, :channels) do
    def exclusive?
      type == :exclusive
    end
  end
  
  attr_reader :server, :channels, :member

  def self.list(...)
    new(...).list
  end

  def initialize(server, channels, member)
    @server   = server
    @channels = channels
    @member   = member
  end

  def prefixed(inclusion_phrase, exclusion_phrase)
    return if list.channels.empty?

    if list.exclusive?
      exclusion_phrase + list.channels
    else
      inclusion_phrase + list.channels
    end
  end

  def list
    @list ||= 
      if use_exclusion_list?
        ChannelsResult.new(:exclusive, exclusion_list)
      else
        ChannelsResult.new(:inclusive, inclusion_list)
      end
  end

  private

  def exclusion_list
    flatten_channels(excluded_channels)
  end

  def inclusion_list
    flatten_channels(channels)
  end

  def excluded_channels
    all_visible_text_channels - channels
  end

  def flatten_channels(channels)
    channels.collect(&:mention).join(', ').strip
  end

  MIN_COUNT_TO_EXCLUSION = 6

  def use_exclusion_list?
    at_least_half_of_channels_included? && channels.size > MIN_COUNT_TO_EXCLUSION 
  end
  
  def at_least_half_of_channels_included?
    channels.size >= (server.text_channels.size / 2)
  end

  def all_visible_text_channels
    server.text_channels.select { |chan| chan.readable_by?(member) }
  end
end