class FriendCode
  class SetOperation
    PLATFORMS = %w[switch 3ds go]

    def self.from_argument(error, arg, command)
      plat, code = arg.downcase.split(/\s+/)

      # support inverted positions
      code, plat = plat, code if plat.match?(SYNTAX)
      
      error[:invalid_platform, arg: plat] unless plat.in?(PLATFORMS)
      error[:missing_platform] if plat.blank?
      
      error[:missing_code, no_help: true, plat: plat] if code.blank?
      error[:malformed, arg: code] unless code.match?(SYNTAX)

      new(plat, code, command.author)
    end

    attr_reader :code, :platform, :member

    def initialize(platform, code, member)
      @member   = member
      @platform = platform
      @code     = FriendCode.normalize(code)
    end

    def save
      if entry
        entry.update(**update_hash)
      else
        create(**create_hash)
      end
    end

    private

    delegate :create, to: :FriendCode

    def entry
      @entry ||= FriendCode[member.id]
    end

    def create_hash
      update_hash.merge(user_id: member.id)
    end

    def update_hash
      { column => code }
    end

    PLATFORM_TO_COLUMN = {
      '3ds'    => :ds3_friend_code,
      'switch' => :switch_friend_code,
      'go'     => :go_friend_code,
    }

    def column
      PLATFORM_TO_COLUMN.fetch(platform)
    end
  end
end