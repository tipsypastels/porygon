module Commands
  class DeletePetCommand < Command
    register %w[delpet delpets]

    args do |a|
      a.arg :id, Integer
    end

    def call(id:)
      pet = Pet.where(id: id, server_id: server.id).first
      return not_found(id) unless pet
      return no_permission unless can_delete?(pet)

      pet.destroy

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('deleted')
      end
    end

    private

    def not_found(id)
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('not_found', id: id)
      end
    end

    def no_permission
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t('no_permission.title')
        e.desc  = t('no_permission.desc')
      end
    end

    DELETE_PERMISSION = :kick_members

    def can_delete?(pet)
      pet.user_id == author.id || author.permission?(DELETE_PERMISSION)
    end
  end
end