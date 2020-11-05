module Discordrb
  class Bot
    def send_message(channel, content, tts = false, embed = nil, attachments = nil)
      channel = channel.resolve_id
      debug("Sending message to #{channel} with content '#{content}'")

      response = API::Channel.create_message \
        token, channel, content, tts, 
        embed ? embed.to_hash : nil, nil, attachments
        
      Message.new(JSON.parse(response), self)
    end
  end
end