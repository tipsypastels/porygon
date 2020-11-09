module Commands
  class AddPetCommand < Command
    register %w[addpet addpets]

    def call
      return no_attachment if message.attachments.empty?

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('added.title')
        e.desc  = t('added.desc', id: pet.id)
      end
    end

    private

    def no_attachment
      embed do |e|
        e.thumb = Porygon::PORTRAIT
        e.color = Porygon::COLORS.warning
        e.title = t('no_attachment.title')
        e.desc  = t('no_attachment.desc')
      end
    end

    def pet
      @pet ||= Pet.from_message(message)
    end
  end
end