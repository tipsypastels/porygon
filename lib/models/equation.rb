class Equation
  VARS  = /[A-z]+\s*=\s*[+-]?\d+(?:\s*,\s*[A-z]+\s*=\s*[+-]?\d+)*/
  MATCH = /(?:#{VARS}\s*||\s*)?[^\|\|]+/

  def self.match
    MATCH
  end

  def initialize(string)
    if string['||']
      vars, @body = string.split(/\s*\|\|\s*/)
      @vars = vars.split(/\s*,\s*/)
                  .collect { |pair| pair.split(/\s*=\s*/) }
                  .to_h
    else
      @body = string
    end
  end

  def result
    calculator = Dentaku::Calculator.new
    calculator.store(**@vars) if @vars
    calculator.evaluate!(@body)
  end
end