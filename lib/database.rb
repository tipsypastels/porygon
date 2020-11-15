Database = Sequel::Database.connect \
  adapter: :postgres,
  user: ENV['DB_USERNAME'],
  password: ENV['DB_PASSWORD'],
  database: ENV['DB']

Database.test_connection