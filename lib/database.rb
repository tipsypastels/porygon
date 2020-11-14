module Database
  CONN = Sequel::Database.connect \
    adapter: :postgres,
    user: ENV['DB_USERNAME'],
    password: ENV['DB_PASSWORD'],
    database: ENV['DB']

  CONN.test_connection

  def self.[](set)
    CONN[set]
  end
end