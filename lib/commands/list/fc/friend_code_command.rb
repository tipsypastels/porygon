module Commands
  class FriendCodeCommand < Command
    register 'fc'

    args do |a|
      a.arg :member, Discordrb::Member, optional: true
    end

    def call(member:)
      member ||= author
      codes = FriendCode[member.id]

      return none(member) unless codes

      embed do |e|
        e.color  = Porygon::COLORS.info
        e.author = member
        e.title  = t('title')
        e.footer = t('footer')

        code_fields(codes).each do |name, value|
          e.field(name, value)
        end
      end
    end

    private

    def code_fields(codes)
      {}.tap do |hash|
        hash[t('ds3')]    = codes.ds3_friend_code
        hash[t('switch')] = codes.switch_friend_code
        hash[t('go')]     = codes.go_friend_code
      end
    end

    def none(member)
      none_scope = author == member ? 'me' : 'other'

      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t("none.#{none_scope}.title", name: member.display_name)
        e.desc  = t("none.#{none_scope}.desc")
      end
    end
  end
end