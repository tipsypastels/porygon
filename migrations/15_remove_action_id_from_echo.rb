Sequel.migration do
  change do
    drop_table :echoed_audit_logs

    create_table(:echoed_audit_logs) do 
      Bignum :server_id, primary_key: true
      Time :creation_time, null: false, index: true
    end
  end
end