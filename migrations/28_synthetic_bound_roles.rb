Sequel.migration do
  change do
    drop_table(:bound_roles)
    drop_table(:bound_role_users)

    create_table(:bound_roles) do
      primary_key :id

      Bigint :role_id, null: false
      Bigint :server_id, null: false

      index %i[role_id server_id], unique: true
    end

    create_table(:bound_role_users) do
      primary_key :id
      Bigint :bound_role_id, null: false
      Bigint :user_id, null: false

      index %i[bound_role_id user_id], unique: true
    end
  end
end