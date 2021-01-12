module Commands
  class RunWithProfilerCommand < Command
    register %w[runwithprofiler], permissions: { owner: true }

    def call
      return unless delegated_command

      embed do |e|
        e.color = Porygon::COLORS.info

        result = DiscordProfilerService.profile { delegated_command.begin_call }
        result.into_embed(e)
      end
    end

    private

    def delegated_command
      @delegated_command ||= Porygon::CommandDetector.detect(message, raw_args)
    end
  end
end