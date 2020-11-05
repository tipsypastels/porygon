module YesNoArgument
  include FromArgument

  TRUE  = %w[true yes on ok ye ya yeah yep]
  FALSE = %w[false no off nope]

  def self.from_argument(arg, *)
    return true if TRUE.include?(arg)
    return false if FALSE.include?(arg)

    arg_err(:malformed, arg: arg)
  end
end