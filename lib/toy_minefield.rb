require_relative 'minefield'

class ToyMinefield < Minefield
  def initialize
    super(3)
  end

  def create_field_with_attributes
    @field = Array.new(size){ Array.new(size){ Cell.new } }
    @number_of_mines = mine_calculator
  end

  def generate_adjacent_mine_counts
    super
  end
end