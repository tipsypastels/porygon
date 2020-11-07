module Commands
  module CommandMixins
    module WithMutedRole
      def with_muted_role
        if (role = server.muted_role)
          yield role
        else
          error_on_lack_of_server_muted_role
        end
      end

      def error_on_lack_of_server_muted_role
        embed do |e|
          e.color       = Porygon::COLORS.warning
          e.title       = I18n.t('command_mixin.with_muted_role.missing.title')
          e.description = I18n.t('command_mixin.with_muted_role.missing.description')
        end
      end
    end
  end
end