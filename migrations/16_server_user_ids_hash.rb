Sequel.migration do
  change do
    create_table(:server_user_id_hashes) do
      Bignum :id, primary_key: true
      Bignum :hash, null: false
    end
  end
end