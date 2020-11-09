module URI
  def self.from_argument(error, arg, *)
    URI(arg)
  rescue InvalidURIError
    error[:malformed, arg: arg]
  end
end