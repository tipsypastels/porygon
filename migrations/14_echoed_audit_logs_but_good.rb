Sequel.migration do
  change do
    drop_table :echoed_audit_logs

    create_table(:echoed_audit_logs) do 
      primary_key :id
      
      Integer :action_id, null: false
      Bignum :server_id, null: false
      Time :creation_time, default: Sequel::CURRENT_TIMESTAMP, index: true

      index %i[action_id server_id], unique: true
    end
  end
end