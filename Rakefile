namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    require 'dotenv/load'
    require 'sequel/core'

    Sequel.extension(:migration)

    version = args[:version]&.to_i
    sequel  = Sequel.connect adapter: :postgres,
                             user: ENV['DB_USERNAME'],
                             password: ENV['DB_PASSWORD'],
                             database: ENV['DB']

    Sequel::Migrator.run(sequel, 'migrations', target: version)
  end
end