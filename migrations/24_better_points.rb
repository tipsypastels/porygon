Sequel.migration do
  change do
    drop_table(:daily_points)

    create_table(:member_points) do
      Bigint :user_id, null: false
      Bigint :server_id, null: false

      Integer :points_this_cycle, default: 0, null: false
      Integer :points_prev_cycle, default: 0, null: false

      primary_key %i[user_id server_id], name: :points_pk
    end
  end
end