Sequel.migration do
  change do
    create_table(:server_settings) do
      Bignum :id, primary_key: true

      TrueClass :enable_me_as_alias_for_current_user, null: false, default: false

      Bignum :mod_log_channel_id, null: true
      Bignum :muted_role_id,      null: true
    end
  end
end