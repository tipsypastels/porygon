Sequel.migration do
  change do
    create_table(:daily_points) do
      Bigint :user_id, null: false
      Bigint :server_id, null: false
      Time :date, null: false

      Integer :points, null: false

      primary_key %i[user_id server_id date], name: :points_pk
    end
  end
end