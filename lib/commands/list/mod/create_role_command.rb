module Commands
  class CreateRoleCommand < Command
    register %w[createrole makerole], 
      permissions: { member: :manage_roles, bot: :manage_roles }

    args do |a|
      a.arg :name, String

      a.optional do
        a.opt :color, Color
        a.opt :hoist
        a.opt :giveme
        a.opt :requestable
        a.opt :mentionable
      end
    end

    def call(**args)
      result = get_result_from_service(args)
      embed_result(result)
    end

    private

    def get_result_from_service(args)
      CreateRoleService.new(server, author, args).create
    end

    def embed_result(result)
      embed do |e|
        e.color = result.color || Porygon::COLORS.ok
        e.title = t('created.title')
        e.desc  = t('created.desc', role: result.mention)

        e.inline do
          e.field(t('color'), result.hex)
          e.field(t('hoisted'), yes_no(result.hoist))
          e.field(t('mentionable'), yes_no(result.mentionable))
          e.field(t('requestable'), yes_no(result.requestable))
        end
      end
    end

    def yes_no(bool)
      t(bool ? 'yes' : 'no')
    end
  end
end