Sequel.migration do
  change do
    rename_table :requestable_role, :requestable_roles
  end
end