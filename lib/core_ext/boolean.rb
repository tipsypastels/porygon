module Boolean
  module_function
  
  TRUE_WORDS  = %w[true yes on ok ye ya yeah yep]
  FALSE_WORDS = %w[false no off nope]

  def from_argument(error, arg, *)
    return true if TRUE_WORDS.include?(arg)
    return false if FALSE_WORDS.include?(arg)

    error[:malformed, arg: arg]
  end

  ::TrueClass.include(self)
  ::FalseClass.include(self)
end