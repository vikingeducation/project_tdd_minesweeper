require_relative 'square'

class Board

  def initialize(height, width)
    @height = height
    @width = width
    @squares = []

    1.upto(width) do |x|
      1.upto(height) do |y|
        @squares << Square.new(x,y)
      end
    end

  end


  def row_status(row_number)
    row = []

    @squares.each do |square|
      row << square.status if square.y == row_number
    end

    row
  end


  def render_row(row)
    row.each { |square| print square }
    print "\n"
  end


  def render
    print "\n"
    @height.downto(1) do |row_number|
        print render_row(row_status(row_number))
    end
    print "\n"
  end


end