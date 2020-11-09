module Commands
  class PetsCommand < Command
    register %w[pets pet]

    args do |a|
      a.arg :member, Discordrb::Member, optional: true
    end

    def call(member:)
      pet, owner = find_pet_and_owner(member)
      return none_found(member) unless pet
      
      embed do |e|
        e.color  = Porygon::COLORS.info
        e.author = owner
        e.image  = pet.url
        e.footer = t('footer', id: pet.id)
      end
    end

    private

    def find_pet_and_owner(member)
      loop do
        pet = Pet.sample(server, member)
        break unless pet

        owner = member || server.member(pet.user_id)
        
        break pet, owner if owner

        pet.destroy
      end
    end

    def none_found(member)
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = 
          if member
            t('none_found.member', name: member.display_name)
          else
            t('none_found.no_member')
          end
      end
    end
  end
end