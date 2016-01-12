require_relative 'grid'


class Minesweeper

  attr_accessor :grid

  def initialize
    @grid = Grid.new
    @grid.build_mines_hash
    @grid.place_bombs
    @grid.calculate_adjacent_bombs
  end


  def reveal_one_square(i, j)
    @grid.grid[i][j].revealed = true
    if @grid.grid[i][j].num_adjacent_bombs == 0
      auto_reveal_multi_square(i,j)
    end
  end

  def user_flags_square(i, j)
    @grid.grid[i][j].flagged = true
  end

  def auto_reveal_multi_square(i, j)
    neighbor_arr = @grid.neighbors(i, j)
    # puts "i: #{i}, j: #{j}"
    neighbor_arr.each do | neighbor | 
      row = neighbor.row
      col = neighbor.col
      # puts "#{row}, #{col}"
      # puts "#{@grid.grid[row][col]}"
      unless @grid.grid[ row ][ col ].revealed 
        @grid.grid[ row ][ col ].revealed = true
        if @grid.grid[row][col].num_adjacent_bombs == 0
          auto_reveal_multi_square( row, col )
        end
      end
    end
  end



  def user_reveal_multi_square
    # all adjacent bombs are flagged correctly

  end



end
