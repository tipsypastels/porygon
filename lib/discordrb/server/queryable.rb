module Discordrb
  class Server
    module Queryable
      def find_role(name)
        if name =~ Role::MENTION_FORMAT
          role($1)
        else
          find_role_by_query(name)
        end
      end

      def find_role_by_query(name)
        roles.detect { |role| role.name.casecmp(name).zero? }
      end

      def find_text_channel(name)
        if name =~ Channel::MENTION_FORMAT
          channel($1.to_i)
        else
          text_channels.detect { |chan| chan.name.casecmp(name).zero? }
        end
      end

      def channel(id)
        text_channels.detect { |chan| chan.id == id }
      end

      def find_member(name)
        if name =~ Member::MENTION_FORMAT
          member($1.to_i)
        else
          find_member_by_query(name)
        end
      end

      def find_member_by_query(name)
        members.detect { |member| member.name_matches_query?(name) }
      end
    end
  end
end