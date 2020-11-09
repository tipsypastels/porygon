Sequel.migration do
  change do
    alter_table(:server_settings) do
      add_column :role_list_url, String, null: true
    end

    create_table(:requestable_role) do
      Bignum :id, primary_key: true
      Bignum :server_id, null: false

      index %i[id server_id], unique: true
    end
  end
end