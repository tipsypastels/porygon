class FriendCode < Sequel::Model
  SYNTAX = /\A\d{4}[- ]*\d{4}[- ]*\d{4}\z/
  NORMALIZE = /(\d{4})(?=\d)/

  unrestrict_primary_key

  def self.normalize(code)
    code.gsub(NORMALIZE, '\1-').delete(' ')
  end

  def validate
    super

    validate_syntax(:go_friend_code, go_friend_code)
    validate_syntax(:ds3_friend_code, ds3_friend_code)
    validate_syntax(:switch_friend_code, switch_friend_code)
  end

  private

  def validate_syntax(code, value)
    errors.add(code, 'syntax') if value && !value.match?(SYNTAX)
  end
end