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

    def call_scoreboard
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = t('scoreboard.name')

        server.each_top_tier_member(limit: 10) do |member, points|
          e.field(member.display_name, points)
        end
      end
    end

    PREDS_TO_TIER_STATE = {
      [true, true]   => :yes,
      [false, true]  => :will_be_removed,
      [true, false]  => :will_be_added,
      [false, false] => :no,
    }.freeze

    def tier_state(member, points)
      passes   = points >= Porygon::Tiers::POINTS 
      has_role = member.role?(role)
      
      PREDS_TO_TIER_STATE.fetch([passes, has_role])
    end

    def role
      server.role(Porygon::Tiers::ROLE)
    end
  end
end