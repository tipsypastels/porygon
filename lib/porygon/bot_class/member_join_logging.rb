module Porygon
  class BotClass
    module MemberJoinLogging
      extend ActiveSupport::Concern

      included do
        attr_reader :member_join_list

        callback :init_member_join_list,  on: :init
        callback :build_member_join_list, on: :connect
      end

      private

      def init_member_join_list
        @member_join_list = MemberJoinList.new
      end

      def build_member_join_list
        @member_join_list.build
      end
    end
  end
end