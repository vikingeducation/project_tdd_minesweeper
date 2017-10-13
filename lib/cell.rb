require_relative 'icon'

class Cell
  include Icon

  attr_accessor :value

  def initialize
    @value = 0
  end

  def revealed?
    false
  end

  def to_s
    "#{value} "
  end

  def flag
    "#{Icon::FLAG} "
  end
end

class Mine < Cell
  def to_s
    "#{Icon::MINE} "
  end
end