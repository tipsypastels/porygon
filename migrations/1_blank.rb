Sequel.migration do
  change do
    create_table(:ignores) do
      primary_key :id
    end
  end
end