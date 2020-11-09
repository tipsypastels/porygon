class Pet < Sequel::Model
  class << self 
    def from_message(message)
      create user_id: message.author.id,
             server_id: message.server.id,
             url: message.attachments.first.url
    end

    def sample(server, user = nil)
      scope = order(Sequel.lit('RANDOM()')).where(server_id: server.id)
      scope = scope.where(user_id: user.id) if user
      scope.limit(1).first
    end
  end
end