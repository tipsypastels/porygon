Sequel.migration do
  change do
    create_table(:cached_messages) do
      Bigint :id, primary_key: true
      Bigint :author_id, null: false
      Bigint :channel_id, null: false
      Bigint :server_id, null: false

      String :content, text: true, null: true
      String :attachment_data, text: true, null: true

      Time :creation_time, null: false
    end
  end
end