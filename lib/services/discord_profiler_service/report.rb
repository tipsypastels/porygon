class DiscordProfilerService
  class Report < StackProf::Report
    MAX_LENGTH    = 2000
    SORT_BY_TOTAL = true

    include Porygon::MessageFormatter

    def into_embed(embed)
      list = frames(SORT_BY_TOTAL)
      text = ''.tap do |buffer|
        list.all? { |_, info| into_embed_line(info, buffer) }
      end

      embed.description = code_block(text)
    end

    private

    # rubocop:disable Style/FormatStringToken
    def into_embed_line(info, buffer)
      percent = format '%2.1f%%', info[:total_samples] * 100.0 / overall_samples

      line = format "(%<total>d, %<percent>s) %<name>s \n",
              name: info[:name],
              total: info[:total_samples],
              percent: percent

      return if line.length + buffer.length > MAX_EMBED_LENGTH

      buffer << line
    end
    # rubocop:enable Style/FormatStringToken
  end
end