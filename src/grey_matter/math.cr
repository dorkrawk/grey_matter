class GreyMatter::Math
  E = 2.7182818284590452353602874713527

  def self.sigmoid_function(value)
    1 / (1 + (E ** (value * -1)))
  end

  def self.sigmoid_function_prime(value)
    self.sigmoid_function(value) * (1 - self.sigmoid_function(value))
  end
end
