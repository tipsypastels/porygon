module Discordrb
  class User
    def owner?
      id == ENV['OWNER']
    end
  end
end