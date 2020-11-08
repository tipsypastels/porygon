module Packages
  class Package
    def self.from_argument(...)
      PackageFinder.find(...)
    end

    include Comparable

    attr_reader :tag

    def initialize(tag)
      @tag = tag
      warn_if_missing_i18n_entry
    end

    def name
      t(:name)
    end

    def desc
      t(:desc)
    end

    def commands
      @commands ||= Commands.select { |command| command.package == self }
                            .sort_by(&:tag)
    end

    def server_ids
      Packages::SERVER_LOCKS[tag]
    end

    def server_specific?
      server_ids.present?
    end

    def supports?(server)
      return true unless server_specific?
      server&.resolve_id.in? server_ids
    end

    def <=>(other)
      name.casecmp(other.name)
    rescue ArgumentError
      nil
    end

    def super_global
      Packages::SUPER_GLOBALS[tag]
    end

    def enable(channels)
      EnabledPackage.enable(tag, channels)
    end

    def disable(channels)
      EnabledPackage.disable(tag, channels)
    end

    def enabled?(channel, member = nil)
      return true if check_super_global(member)
      EnabledPackage.enabled?(channel, tag)
    end

    def enabled_in_at_least_one_channel?(server, member = nil)
      return true if check_super_global(member)
      EnabledPackage.enabled_in_at_least_one_channel?(tag, server)
    end

    def channels(server)
      EnabledPackage.enabled_channels(tag, server)
    end

    private

    def check_super_global(member)
      member && super_global&.call(member)
    end

    def warn_if_missing_i18n_entry
      t(:name, default: false) || 
        Porygon::LOGGER.warn("Package \"#{tag}\" has no language file entry!")
    end

    def t(key, **interps)
      I18n.t("packages.#{tag}.#{key}", **interps)
    end
  end
end