module Commands
  class RoleListCommand < Command
    register 'rolelist'

    def call
      return none unless url

      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('result.title')
        e.desc  = t('result.desc', url: url)
      end
    end

    private

    def none
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('none')
      end
    end

    def url
      server.role_list_url
    end
  end
end