Sequel.migration do
  change do
    create_table(:member_join_dates) do
      primary_key :id

      Bignum :user_id, null: false
      Bignum :server_id, null: false
      Time :joined_at

      index %i[user_id server_id], unique: true
    end
  end
end