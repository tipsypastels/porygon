module Discordrb
  module API
    module Channel
      module_function

      # rubocop:disable Metrics/MethodLength, Layout/LineLength
      def create_message(
        token, 
        channel_id, 
        message, 
        tts = false, 
        embed = nil, 
        nonce = nil, 
        attachments = nil
      )
        body = { content: message, tts: tts, embed: embed, nonce: nonce }
        body = 
          if attachments
            files = [*0...attachments.size].zip(attachments).to_h
            { **files, payload_json: body.to_json }
          else
            body.to_json
          end

        headers = { Authorization: token }
        headers[:content_type] = :json unless attachments

        Discordrb::API.request(
          :channels_cid_messages_mid,
          channel_id,
          :post,
          "#{Discordrb::API.api_base}/channels/#{channel_id}/messages",
          body,
          **headers,
        )
      rescue RestClient::BadRequest => e
        parsed = JSON.parse(e.response.body)
        raise Discordrb::Errors::MessageTooLong, "Message over the character limit (#{message.length} > 2000)" if parsed['content']&.is_a?(Array) && parsed['content'].first == 'Must be 2000 or fewer in length.'

        raise
      end
    end
    # rubocop:enable Metrics/MethodLength, Layout/LineLength
  end
end