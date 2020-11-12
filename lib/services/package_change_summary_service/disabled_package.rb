class PackageChangeSummaryService
  class DisabledPackage < GenericChangeObject
    include Porygon.i18n_scope('services.package_change_summary.disabled')

    def no_change?
      channels.none? { |chan| chan.id.in?(currently_enabled_channel_ids) }
    end
  end
end