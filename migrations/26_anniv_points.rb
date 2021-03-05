Sequel.migration do
  change do
    create_table(:anniv_team_points) do
      Bignum :role_id, primary_key: true
      Integer :points, null: false, default: 0
    end
  end
end