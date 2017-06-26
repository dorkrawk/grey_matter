class GreyMatter::Math
  E = 2.7182818284590452353602874713527

  def self.sigmoid_function(value)
    1 / (1 + (E ** (value * -1)))
  end

  def self.sigmoid_function_prime(value)
    self.sigmoid_function(value) * (1 - self.sigmoid_function(value))
  end

  def self.matrix_mul(array1, array2)
    array1.zip(array2).map { |a, b| a * b }
  end

  def self.matrix_scalar(array, scalar)
    array.map { |v| v * scalar }
  end

  def self.matrix_add(array1, array2)
    array1.zip(array2).map { |a, b| a + b }
  end

  def self.matrix_sub(array1, array2)
    array1.zip(array2).map { |a, b| a - b }
  end
end
