Sequel.migration do
  change do
    alter_table(:ignored_users) do
      rename_column :ignored_by_user_id, :mod_id
    end
  end
end