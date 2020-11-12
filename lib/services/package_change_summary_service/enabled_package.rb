class PackageChangeSummaryService
  class EnabledPackage < GenericChangeObject
    include Porygon.i18n_scope('services.package_change_summary.enabled')

    def summarize
      if newly_enabled_channels.present?
        stat :enabled, channels: to_list(newly_enabled_channels)
      end

      if already_enabled_channels.present?
        stat :already, channels: to_list(already_enabled_channels)
      end

      if newly_enabled_channels.present? && already_enabled_channels.present?
        stat :total, channels: to_smart_list(channels)
      end
    end

    def newly_enabled_channels
      @newly_enabled_channels ||= channels - already_enabled_channels
    end

    def already_enabled_channels
      @already_enabled_channels ||=
        channels.select { |chan| chan.id.in?(currently_enabled_channel_ids) }
    end

    def all_channels
      newly_enabled_channels + already_enabled_channels
    end
  end
end