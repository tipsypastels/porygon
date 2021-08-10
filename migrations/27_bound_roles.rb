Sequel.migration do
  change do
    create_table(:bound_roles) do
      Bigint :role_id, null: false
      Bigint :server_id, null: false

      primary_key %i[role_id server_id]
    end

    create_table(:bound_role_users) do
      Bigint :role_id, null: false
      Bigint :user_id, null: false
      Bigint :server_id, null: false

      primary_key %i[user_id role_id server_id]
    end
  end
end