module Commands
  class PointsCommand < Command
    register 'points', permissions: { member: :kick_members }

    args do |a|
      a.arg :member, Discordrb::Member, optional: true
    end

    def call(member:)
      member ? call_member_points(member) : call_scoreboard
    end

    private

    def call_member_points(member)
      points = Porygon::Tiers.fetch(member)
      
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = member.display_name
        e.thumb = member.avatar_url

        e.field(t('member.points'), points)
        
        e.field(
          t('member.tier_state.name', name: role.name), 
          t("member.tier_state.#{tier_state(member, points)}"),
        )

        e.footer = t('member.footer')
      end
    end

    SCOREBOARD_LENGTH = 10

    def call_scoreboard
      entries = Porygon::Tiers.top(server, SCOREBOARD_LENGTH)

      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('scoreboard.name')

        entries.each do |entry|
          member = server.member(entry[:user_id])
          username = member&.display_name || t('scoreboard.unknown')

          e.field(username, entry[:points])
        end
      end
    end

    def tier_state(member, points)
      passes   = pass?(points)
      has_role = role?(member)
      
      case # rubocop:disable Style/EmptyCaseCondition
      when passes && has_role
        :yes
      when has_role
        :will_be_removed
      when passes
        :will_be_added
      else
        :no
      end
    end

    def role?(member)
      member.role?(role)
    end

    def role
      server.role(Porygon::Tiers::ROLE)
    end

    def pass?(points)
      points >= Porygon::Tiers::POINTS
    end
  end
end