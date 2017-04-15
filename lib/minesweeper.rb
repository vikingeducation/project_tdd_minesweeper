require_relative 'cell'

class Minesweeper
  def initialize(rows = 10, columns = 10, mines = 9)
    @row = rows
    @col = columns
    @bombs = mines
    @board = []
    @flags_left = @bombs
    @start_time = Time.now
    create_board
  end

  def turn
    puts "\nEnter your move: "
    player_move = gets.strip.upcase.split(',')
    unless valid_move?(player_move)
      puts "Invalid Move!"
      return false
    end
    player_move[0] = player_move[0].to_i - 1
    player_move[1] = player_move[1].to_i - 1
    case player_move[2]
    when 'C'
      toggle_cover(player_move[0], player_move[1])
    when 'F'
      toggle_flag(player_move[0], player_move[1])
    end
    render
  end

  def render
    puts "\nThe board: "
    @row.times do |row_iter|
      @col.times do |col_iter|
        print @board[row_iter][col_iter].render
        print ' '
      end
      print "\n"
    end
    puts "#{(Time.now - @start_time).round} seconds elapsed"
  end

  def uncover_board
    @row.times do |row_iter|
      @col.times do |col_iter|
        @board[row_iter][col_iter].flag=(false)
        @board[row_iter][col_iter].cover=(false)
      end
    end
  end

  def game_over?
    game_over = 0
    @row.times do |row_iter|
      @col.times do |col_iter|
        game_over += 1 if (@board[row_iter][col_iter].cover == false) && (@board[row_iter][col_iter].bomb == false)
      end
    end
    if game_over == (@row * @col - @bombs)
      puts "\nYou won!!"
      return true
    end
    false
  end

  def print_instructions
    puts 'Welcome to CLI Minesweeper!!!'
    puts "\n"
    puts 'The board renders with: '
    puts '   # - means a covered square'
    puts '   | - means a flag is placed on that cell'
    puts '   _ - means an empty cell'
    puts '   X - means a bomb is in that cell'
    puts '   A number is the number of bombs in adjacent cells'
    puts "\n"
    puts 'Your goal is clear the board without detonating a bomb.  A flag can'
    puts ' be used to mark a suspected bomb and protect the cell from going off!'
    puts ' You must remove a flag before you can uncover a cell.'
    puts "\n"
    puts 'Enter a move by typing row,col,action like 3,8,F where '
    puts ' action is one of F - toggle flag, C - uncover cell.'
    puts "\n"
    render
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
    find_adjacent(target_row, target_col).each do |cell|
      bomb_count += 1 if @board[cell[0]][cell[1]].bomb
    end
    bomb_count
  end

  def valid_move?(player_move)
    return false if player_move.length != 3
    return false unless player_move[2] =~ /[CF]/
    return false unless player_move[0].to_i > 0 && player_move[0].to_i <= @row
    return false unless player_move[1].to_i > 0 && player_move[1].to_i <= @col
    true
  end

  def toggle_cover(target_row, target_col)
    if @board[target_row][target_col].toggle_cover
      puts "\nYou lose!"
      uncover_board
      render
      exit
    else clear_adjancent(target_row, target_col)
    end
  end

  def toggle_flag(target_row, target_col)
    return puts 'No more flags' unless @board[target_row][target_col].flag || @flags_left > 0
    @board[target_row][target_col].toggle_flag
    @board[target_row][target_col].flag ? @flags_left -= 1 : @flags_left += 1
    puts "#{@flags_left} flag(s) remaining"
  end

  def clear_adjancent(target_row, target_col)
    return unless @board[target_row][target_col].adjacent_bombs.zero?
    @board[target_row][target_col].toggle_cover
    find_adjacent(target_row, target_col).each do |cell|
      next unless @board[cell[0]][cell[1]].cover
      clear_adjancent(cell[0], cell[1])
    end
  end

  def find_adjacent(target_row, target_col)
    adjacent = []
    adjacent_valid = []
    adjacent << [target_row - 1, target_col - 1]
    adjacent << [target_row - 1, target_col]
    adjacent << [target_row - 1, target_col + 1]
    adjacent << [target_row, target_col - 1]
    adjacent << [target_row, target_col + 1]
    adjacent << [target_row + 1, target_col - 1]
    adjacent << [target_row + 1, target_col]
    adjacent << [target_row + 1, target_col + 1]
    adjacent.each do |cell|
      adjacent_valid << cell if in_bounds?(cell)
    end
    adjacent_valid
  end

  def in_bounds?(cell)
    return false if cell[0] < 0
    return false if cell[0] >= @row
    return false if cell[1] < 0
    return false if cell[1] >= @col
    true
  end
end
