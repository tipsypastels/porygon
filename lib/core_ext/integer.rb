class Integer
  def self.from_argument(error, arg, *)
    Integer(arg)
  rescue TypeError, ArgumentError
    error[:malformed, arg: arg]
  end
end