Sequel.migration do
  change do
    drop_table :server_user_id_hashes
  end
end