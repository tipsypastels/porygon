Sequel.migration do
  change do
    alter_table(:server_settings) do
      set_column_type :warning_log_channel_id, :Bignum
    end
  end
end