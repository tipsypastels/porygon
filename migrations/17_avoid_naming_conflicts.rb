Sequel.migration do
  change do
    alter_table(:server_user_id_hashes) do
      rename_column :hash, :user_ids_hash
    end
  end
end