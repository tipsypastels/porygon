Sequel.migration do
  change do
    create_table(:friend_codes) do
      Bignum :user_id, primary_key: true

      String :go_friend_code
      String :ds3_friend_code
      String :switch_friend_code
    end
  end
end