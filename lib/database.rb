module Database
  unless ENV['NOSTART']
    CONN = Sequel::Database.connect \
      adapter: :postgres,
      user: ENV['DB_USERNAME'],
      password: ENV['DB_PASSWORD'],
      database: ENV['DB'],
      logger: Porygon::LogDelegator.new('QUERY')

    CONN.test_connection
  end
end