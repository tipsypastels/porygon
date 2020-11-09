Sequel.migration do
  change do
    alter_table(:echoed_audit_logs) do
      add_column :server_id, Bignum, null: false
    end
  end
end