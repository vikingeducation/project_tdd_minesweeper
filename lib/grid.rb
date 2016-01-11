require 'square'

class Grid

  attr_accessor :grid

  def initialize(grid=nil)
    @height = 9
    @width = 9
    @num_mines = 10
    @grid = Array.new(@width){Array.new(@height){Square.new("unmarked")}}
  end


  def place_bombs
    mines_hash = {}
    until mines_hash.length == @num_mines do
      loop do 
        x,y = rand(0..@height-1), rand(0..@width-1)
        print mines_hash
        unless mines_hash[[x,y]]
          mines_hash[[x,y]] = true
          break
        end
      end
    end
    @grid.each_with_index do |row, i|
      row.each_with_index do |column, j|
        mines_hash.include?([i,j]) ? @grid[i][j].status = "bomb" : @grid[i][j].status = "nobomb"

      end
    end
  end

end