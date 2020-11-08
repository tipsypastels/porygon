Sequel.migration do
  change do
    alter_table(:enabled_packages) do
      set_column_not_null :channel_id
    end
  end
end