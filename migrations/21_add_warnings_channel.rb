Sequel.migration do
  change do
    alter_table(:server_settings) do
      add_column :warning_log_channel_id, Bignum, null: true
    end
  end
end