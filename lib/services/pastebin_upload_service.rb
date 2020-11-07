class PastebinUploadService
  API_URI = URI('https://pastebin.com/api/api_post.php')

  attr_reader :message, :privacy, :raw_url, :name

  PUBLIC   = 0
  UNLISTED = 1
  PRIVATE  = 2
  
  def initialize(message, privacy: UNLISTED, raw_url: true, name: SecureRandom.hex)
    @message  = message
    @privacy  = privacy
    @raw_url  = raw_url
    @name     = name
  end

  def upload
    res = Net::HTTP.post_form(API_URI, **body)
    format_url(res.body)
  end

  private

  def body
    {
      'api_option'        => 'paste',
      'api_paste_private' => privacy,
      'api_paste_name'    => name,
      'api_dev_key'       => api_key,
      'api_paste_code'    => message,
    }
  end

  def format_url(url)
    raw_url ? url.sub('pastebin.com/', 'pastebin.com/raw/') : url
  end

  def api_key
    ENV.fetch('PASTEBIN_KEY')
  end
end