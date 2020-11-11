module Commands
  class SetFriendCodeCommand < Command
    register 'setfc'

    def self.custom_missing
      raise UsageError.new(
        'conversions.friend_code/set_operation.missing', no_help: true
      )
    end

    args do |a|
      a.arg :setter, FriendCode::SetOperation, default: -> { custom_missing }
    end

    def call(setter:)
      setter.save
      
      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('title')
        e.desc  = t('desc', name: author.display_name)
      end
    end
  end
end