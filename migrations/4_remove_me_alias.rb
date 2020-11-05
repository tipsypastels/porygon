Sequel.migration do
  change do
    alter_table(:server_settings) do
      drop_column :enable_me_as_alias_for_current_user
    end
  end
end