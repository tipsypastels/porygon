class DiscordProfilerService
  include Porygon::MessageFormatter

  MAX_EMBED_LENGTH = 2000

  def self.profile(**opts, &block)
    new(**opts).report(block)
  end

  def initialize(**opts)
    @opts = opts.reverse_merge(ignore_gc: true)
  end

  def report(proc)
    @report ||= Report.new(profile(proc))
  end

  private

  def profile(proc)
    @profile ||= StackProf.run(**@opts, &proc)
  end
end