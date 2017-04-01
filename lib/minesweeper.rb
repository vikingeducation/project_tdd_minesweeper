require_relative 'player'
require_relative 'board'
require_relative 'cell'

class Minesweeper
  def initialize
    @game_over = false
  end

  def main
    columns = nil
    mines = nil
    print 'Hello, please enter your name: '
    name = gets.chomp
    @player = Player.new(name)
    instructions
    loop do #cols
      print 'Please enter the number of columns for your board between 5 and 25: '
      columns = gets.chomp.to_i
      break if valid_number_cols(columns)
    end
    loop do #mines
      print 'Please enter the number of mines for your board between 5 and 100 and the game will begin: '
      mines = gets.chomp.to_i
      break if valid_number_mines(mines)
    end
    @board = Board.new(columns, mines)
    @board.render
    while !@game_over do
      row_input = nil
      col_input = nil
      loop do #row_input
        print "Enter row of square you'd like to choose or 'f' to place a flag: "
        row_input = gets.chomp
        if valid_row_input(row_input)
         row_input -= 1 if row_input.is_a?Integer
         break
        end
      end
      if row_input == "f"
        flag_row = nil
        flag_col = nil
        loop do #flag_row
          print "Enter row to place flag: "
          flag_row = gets.chomp.to_i - 1
          break if valid_coord_inp(flag_row)
        end
        loop do #flag_col
          print "Enter column to place flag: "
          flag_col = gets.chomp.to_i - 1
          break if valid_coord_inp(flag_col)
        end
        (@board.board[flag_row][flag_col]).flagged = true
        @board.render
      else
        loop do #choice_row
          print "Enter column of square you'd like to choose: "
          col_input = gets.chomp.to_i - 1
          break if valid_coord_inp(col_input)
        end
        process_square(row_input.to_i - 1, col_input)
        @board.render
        victory
      end
    end
    puts "Thanks for playing"
  end

  def instructions
    puts "You will select the number of columns and rows for the board as well as the number of mines to clear which are presented in a board of squares.  Some squares contain mines, others don't.  If you click on  a square containing a mine, you lose.  If you reveal all the squares without mines in the time allowed, you win.  If time runs out, you lose."
    puts "Clicking on a square which doesn't have a bomb reveals the number of neighboring (horizontal, vertical, and diagonal) squares containing mines.  Use this information plus some guess work to avoid the mines."
    puts "To reveal a square, enter its coordinates at the prompt.  To flag a suspected mine square type 'F' at the prompt and then enter the coordinates."
  end

  def valid_number_cols(columns)
    return (columns.is_a?Integer) && (columns >= 5) && (columns <= 25)
  end

  def valid_number_mines(mines)
    return (mines.is_a?Integer) && (mines >= 5) && (mines <= 100)
  end

  def valid_row_input(inp)
    if inp == "f"
      return true
    else
      inp = inp.to_i - 1
      return (inp.is_a?Integer) && (inp >= 0) && (inp <= (@board.columns - 1))
    end
  end

  def valid_coord_inp(inp)
    return (inp.is_a?Integer) && (inp >= 0) && (inp <= (@board.columns - 1))
  end

  def process_square(row, col)
    current = Time.now.to_f
    start = @board.start_time.to_f
    sec = @board.game_time.to_f
    @board.board[row][col].revealed = true
    @board.board[row][col].flagged = false
    if (@board.board[row][col]).is_mine
      puts "You uncovered a mine.  Game Over"
      @game_over = true
    elsif current > (sec + start)
      puts "You are out of time.  Game Over"
      @game_over = true
    elsif ((@board.board[row][col]).value_sym) == :X
      clear_squares(row, col)
    end
  end

  def clear_squares(row, col)
      reveal_sq((row - 1),(col - 1)) if (((row > 0) && (col > 0)) && ((@board.board[row - 1][col - 1]).revealed == false)) #top left
      reveal_sq((row - 1),(col)) if ((row > 0 ) && ((@board.board[row - 1][col]).revealed == false)) #top
      reveal_sq((row - 1),(col + 1)) if ((row > 0 && col < @board.columns - 1) && ((@board.board[row - 1][col + 1]).revealed == false)) #t r
      reveal_sq((row),(col + 1)) if ((col < @board.columns - 1) && ((@board.board[row][col + 1]).revealed == false)) #right
      reveal_sq((row + 1),(col + 1)) if ((row < @board.columns - 1 && col < @board.columns - 1) && ((@board.board[row + 1][col + 1]).revealed == false)) #bot right
      reveal_sq((row + 1),(col)) if ((row < @board.columns - 1) && ((@board.board[row + 1][col]).revealed == false)) # bot
      reveal_sq((row + 1),(col - 1)) if ((row < @board.columns - 1 && col > 0) && ((@board.board[row + 1][col - 1]).revealed == false)) #bot left
      reveal_sq((row),(col + 1)) if ((col < @board.columns - 1) && ((@board.board[row][col + 1]).revealed == false)) #left
  end

  def reveal_sq(r, c)
    cell = @board.board[r][c]
    if cell.value_sym == :X
      cell.revealed = true
      clear_squares(r, c)
    elsif cell.value_sym == :M
      cell.revealed = false
    else
      cell.revealed = true
    end
  end

  def victory
    if @game_over == true
      return
    else
      unrevealed_count = 0
      @board.board.each do |row|
        row.each do |cell|
          if cell.revealed == false
            unrevealed_count += 1
          end
        end
      end
      if unrevealed_count == @board.mines
        @game_over = true
        puts "You Win!"
      end
    end
  end
end
ms = Minesweeper.new
ms.main
