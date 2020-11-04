Sequel.migration do
  change do
    create_table(:ignored_users) do
      primary_key :id

      Bignum   :user_id, null: false
      Bignum   :server_id, null: true
      Bignum   :ignored_by_user_id, null: false
      DateTime :ignored_at, default: Sequel::CURRENT_TIMESTAMP, index: true

      index %i[user_id server_id], unique: true
    end
  end
end