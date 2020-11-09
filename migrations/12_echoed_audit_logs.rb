Sequel.migration do
  change do
    create_table(:echoed_audit_logs) do 
      String :action, primary_key: true
      Time :creation_time, default: Sequel::CURRENT_TIMESTAMP, index: true
    end
  end
end