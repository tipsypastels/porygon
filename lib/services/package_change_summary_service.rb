class PackageChangeSummaryService
  attr_reader :server, :member, :packages, :channels, :action
  
  def initialize(server, member, packages, channels, action:)
    @server   = server
    @member   = member
    @packages = packages
    @channels = channels
    @action   = action
  end

  def into_embed(embed)
    changes.each { |change| embed.field(change.name, change.summary) }
  end

  def changes
    @changes ||= packages.map { |package| to_change_object(package) }
  end

  private

  CHANGE_OBJECT_FACTORY = {
    enabled: EnabledPackage,
    disabled: DisabledPackage,
  }

  def to_change_object(package)
    change_object_class.new(package, server, member, channels)
  end

  def change_object_class
    CHANGE_OBJECT_FACTORY.fetch(action)
  end
end