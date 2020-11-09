module Commands
  # rubocop:disable all
  class ShimPcimportpetsCommand < Command
    register '%shim_pcimportpets', permissions: { owner: true }


    PETS = JSON.parse(File.read('lib/commands/list/operator/marin_pets.json'))

    def call
      PETS.each do |data|
        user_id = data['userid'].to_i
        url = data['url']

        next unless server.member(user_id)

        Pet.create(user_id: user_id, url: url, server_id: server.id)
      end
    end
  end
  # rubocop:enable all
end