module Database
  CONN = Sequel::Database.connect \
    adapter: :postgres,
    user: ENV['DB_USERNAME'],
    password: ENV['DB_PASSWORD'],
    database: ENV['DB']

  CONN.test_connection

  def self.start_logging
    CONN.logger = Porygon::LogDelegator.new('QUERY')
  end
end