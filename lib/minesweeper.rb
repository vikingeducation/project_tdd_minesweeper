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
    # puts i, j, @grid.grid[i][j].revealed
    @grid.grid[i][j].revealed = true
    game_lost if @grid.grid[i][j].has_bomb
    if @grid.grid[i][j].num_adjacent_bombs == 0
      auto_reveal_multi_square(i,j)
    end
    puts i, j, @grid.grid[i][j].revealed
  end

  def user_flags_square(i, j)
    @grid.grid[i][j].flagged = true
  end

  def auto_reveal_multi_square(i, j)
    neighbor_arr = @grid.neighbors(i, j)
    neighbor_arr.each do | neighbor | 
      row = neighbor.row
      col = neighbor.col
      unless @grid.grid[ row ][ col ].revealed 
            reveal_one_square(row, col)
      end
    end
  end

  def game_lost
    puts "you stepped on a bomb, sorry"
  end

  def user_reveal_multi_square(i, j)
    # all adjacent bombs are flagged correctly
     if @grid.grid[i][j].num_adjacent_bombs == @grid.calculate_adjacent_flags(i, j)
        auto_reveal_multi_square(i, j)
     end
  end

    def get_square_input
        input = nil
        loop do
              input = gets.chomp
              break if input != nil
        end
        input
    end

    def play
        #print_instructions
        #render_grid
        loop do
            # puts "got in outer loop"
            #Choose
            # 1: reveal one square
            # 2: reveal multiple squares
            # 3: flag a square
            # 4: new game
            # 5: quit
            input = gets.chomp.to_i
            if input == 1
                puts "got in input loop"
                square = get_square_input
                i, j = square.split(",").map!  { |c| c.to_i }
                puts i, j
                reveal_one_square(i, j)
            end
            break if input >= 1 && input <= 5
        end
    end


end
