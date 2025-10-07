# Step 1: Abstract Expression
class Expression
  def interpret
    raise NotImplementedError
  end
end

# Step 2: Terminal Expressions
class Number < Expression
  def initialize(value)
    @value = value
  end

  def interpret
    @value
  end
end

class Add < Expression
  def initialize(left, right)
    @left = left
    @right = right
  end

  def interpret
    @left.interpret + @right.interpret
  end
end

class Subtract < Expression
  def initialize(left, right)
    @left = left
    @right = right
  end

  def interpret
    @left.interpret - @right.interpret
  end
end

# Usage
# Represents: 5 + (10 - 3)
expr = Add.new(
  Number.new(5),
  Subtract.new(Number.new(10), Number.new(3))
)

puts expr.interpret  # => 12
