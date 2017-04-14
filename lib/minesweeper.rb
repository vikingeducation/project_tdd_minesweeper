require_relative 'cell'

class Minesweeper
  def initialize(rows = 10, columns = 10)
    @row = rows
    @col = columns
    @bombs = (rows * columns * 0.25).floor
    @board = []
    create_board
  end

  def turn
    render
  end

  def render
    puts 'The current board: '
    @row.times do |row_iter|
      @col.times do |col_iter|
        print @board[row_iter][col_iter].render
        print ' '
      end
      print "\n"
    end
  end

  private

  def create_board
    @row.times do
      new_row = []
      @col.times do
        new_row << Cell.new
      end
      @board << new_row
    end
    add_bombs
    set_adjacent_bomb_count
  end

  def add_bombs
    @bombs.times do
      until put_bomb
      end
    end
  end

  def put_bomb
    target_row = rand(@row)
    target_col = rand(@col)
    @board[target_row][target_col].bomb ? (return false) : @board[target_row][target_col].bomb = true
    true
  end

  def set_adjacent_bomb_count
    @row.times do |row_iter|
      @col.times do |col_iter|
        @board[row_iter][col_iter].adjacent_bombs=(count_bombs(row_iter, col_iter))
      end
    end
  end

  def count_bombs(target_row, target_col)
    bomb_count = 0
    if target_row > 0
      target_col > 0 ? (bomb_count += 1 if @board[target_row - 1][target_col - 1].bomb) : 0
      bomb_count += 1 if @board[target_row - 1][target_col].bomb
      target_col < (@col - 1) ? (bomb_count += 1 if @board[target_row - 1][target_col + 1].bomb) : 0
    end
    target_col > 0 ? (bomb_count += 1 if @board[target_row][target_col - 1].bomb) : 0
    target_col < (@col - 1) ? (bomb_count += 1 if @board[target_row][target_col + 1].bomb) : 0
    if target_row < (@row - 1)
      target_col > 0 ? (bomb_count += 1 if @board[target_row + 1][target_col - 1].bomb) : 0
      bomb_count += 1 if @board[target_row + 1][target_col].bomb
      target_col < (@col - 1) ? (bomb_count += 1 if @board[target_row + 1][target_col + 1].bomb) : 0
    end
    bomb_count
  end
end
