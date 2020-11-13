# don't use this for !packageList, its semantics are slightly different
# TODO: package visibility rewrite unifying them, but not tonight
class CommandListService
  def self.list(...)
    new(...).list
  end

  attr_reader :member, :channel
  delegate :server, to: :channel

  def initialize(member, channel)
    @member  = member
    @channel = channel
  end

  def list
    Packages.filter_map do |package|
      next unless package.supports?(server)
      next unless package.enabled_in_at_least_one_channel?(server, member)

      channels = package_channels(package)
      commands = package_commands(package)
      
      if channels.present? && commands.present?
        PackageResult.new(package, channels, commands)
      end
    end
  end

  private

  PackageResult = Struct.new(:package, :channels, :commands) do
    delegate :name, :super_global, to: :package
  end

  def package_channels(package)
    package.channels(server).select { |chan| chan.readable_by?(member) }
  end

  def package_commands(package)
    package.commands.select do |command|
      CommandAccessService.new(member, channel, command).check_member
    end
  end
end