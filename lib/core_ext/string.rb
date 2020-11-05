class String
  include FromArgument

  def self.from_argument(arg, *)
    arg.to_s
  end
end