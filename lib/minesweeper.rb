require_relative 'grid'


class Minesweeper

  attr_accessor :grid

  def initialize
    @grid = Grid.new
    @grid.build_mines_hash
    @grid.place_bombs
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

  def auto_reveal_multi_square
  end



  def user_reveal_multi_square
    # all adjacent bombs are flagged correctly

  end



end

# ms = Minesweeper.new
# puts ms.grid.class