class ChannelListService
  attr_reader :server, :channels
  attr_reader :include_phrase, :exclude_phrase

  def self.list(...)
    new(...).list
  end

  def initialize(server, channels, include_phrase = '', exclude_phrase = '')
    @server   = server
    @channels = channels

    @include_phrase = include_phrase
    @exclude_phrase = exclude_phrase
  end

  def list
    if use_exclusion_list?
      exclusion_list
    else
      inclusion_list
    end
  end

  private

  def exclusion_list
    exclude_phrase + flatten_channels(excluded_channels)
  end

  def inclusion_list
    include_phrase + flatten_channels(channels)
  end

  def excluded_channels
    server.text_channels - channels
  end

  def flatten_channels(channels)
    channels.collect(&:mention).join(', ')
  end

  MIN_COUNT_TO_EXCLUSION = 6

  def use_exclusion_list?
    at_least_half_of_channels_included? && channels.size > MIN_COUNT_TO_EXCLUSION 
  end
  
  def at_least_half_of_channels_included?
    channels.size >= (server.text_channels.size / 2)
  end
end