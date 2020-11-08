Sequel.migration do
  change do
    create_table(:enabled_packages) do
      primary_key :id

      Bignum :channel_id, null: true
      Bignum :server_id, null: false
      String :tag, null: false

      index %i[server_id channel_id tag], unique: true
      index %i[channel_id tag], unique: true
    end
  end
end