Sequel.migration do
  change do
    alter_table(:enabled_packages) do
      rename_column :channels, :channel_ids
    end
  end
end