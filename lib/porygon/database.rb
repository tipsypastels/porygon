module Porygon
  class Database < Sequel::Database
    def self.connect
      return if ENV['NOSTART']

      db = super adapter: :postgres,
                 user: ENV['DB_USERNAME'],
                 password: ENV['DB_PASSWORD'],
                 database: ENV['DB']

      db.tap(&:test_connection)
    end
  end
end