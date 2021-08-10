Sequel.extension :pg_json
Sequel.migration do
  change do
    drop_table(:bound_roles)

    create_table(:bound_roles) do
      Bigint :role_id, null: false
      Bigint :server_id, null: false
      JSON :user_ids, default: [], null: false

      primary_key %i[role_id server_id]
    end
  end
end