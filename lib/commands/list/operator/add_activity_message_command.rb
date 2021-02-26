module Commands
  class AddActivityMessageCommand < Command
    register 'addactivitymessage', permissions: { owner: true }

    args do |a|
      a.arg :message, String
      a.opt :switch, optional: true
    end

    def call(message:, switch:)
      Porygon::ActivityMessage.add(message)
      Bot.activity = message if switch

      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('done')
        e.desc  = message
      end
    end
  end
end