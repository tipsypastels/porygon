module Commands
  class SetRoleListUrlCommand < Command
    register 'setrolelisturl', permissions: { member: :manage_server }

    args do |a|
      a.arg :url, URI
    end

    def call(url:)
      server.role_list_url = url

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('done.title')
        e.desc  = t('done.desc')
      end
    end
  end
end