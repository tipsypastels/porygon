Sequel.migration do
  change do
    create_table(:pets) do
      primary_key :id

      Bignum :server_id, null: false
      Bignum :user_id, null: false
      String :url, null: false
    end
  end
end