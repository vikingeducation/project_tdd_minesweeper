require_relative 'cell'

class Board
  attr_accessor :board, :board_size, :bombs, :count
  attr_reader :game_over

  def initialize (board_size = 10, bombs = 9)
    @count = (board_size ** 2) - bombs
    @board = {}
    @board_size = board_size
    @bombs = bombs
    @flags_nb = bombs
    @game_over = false
    create_board(board_size)
  end

  def create_board (board_size)
    (1..board_size).each do |col|
      @board[col] = {}
    end

    (1..board_size).each do |col|
      (1..board_size).each do |row|
        @board[col][row] = Cell.new
      end
    end
  end

  def create_bombs
    @bombs.times do |cell|
      bomb_placed = false
      until bomb_placed
        col = rand(1..@board_size)
        row = rand(1..@board_size)
        unless select_cell(col, row).state == "B"
          select_cell(col, row).state = "B"
          select_cell(col, row).is_bomb = true
          bomb_placed = true
        end
      end
    end
  end

  def create_bomb_indication

    @board.each do |col_idx, col|
      col.each do |row_idx, cell|
        if col_idx > 1
          if @board[col_idx-1][row_idx].state == "B" 
            cell.state += 1 unless cell.state == "B"
          end
        end
        if col_idx < @board_size
          if @board[col_idx+1][row_idx].state == "B"
            cell.state += 1 unless cell.state == "B"
          end
        end
        if row_idx > 1
          if @board[col_idx][row_idx-1].state == "B"
            cell.state += 1 unless cell.state == "B"
          end
        end
        if row_idx < @board_size
          if @board[col_idx][row_idx+1].state == "B"
            cell.state += 1 unless cell.state == "B"
          end
        end
        if col_idx > 1 && row_idx > 1
          if @board[col_idx-1][row_idx-1].state == "B"
            cell.state += 1 unless cell.state == "B"
          end
        end
        if col_idx > 1 && row_idx < @board_size
          if @board[col_idx-1][row_idx+1].state == "B"
            cell.state += 1 unless cell.state == "B"
          end
        end
        if col_idx < @board_size && row_idx < @board_size
          if @board[col_idx+1][row_idx+1].state == "B"
            cell.state += 1 unless cell.state == "B"
          end
        end
        if col_idx < @board_size && row_idx > 1
          if @board[col_idx+1][row_idx-1].state == "B"
            cell.state += 1 unless cell.state == "B"  
          end
        end
      end
    end
  end

  def select_cell(col, row)
    @board[col][row]
  end

  def render_board (reveal = nil)
    @board_size > 9 ? (print "##|") : (print "#|")

    @board_size.times {|i| print "#{i+1}|"}
    puts
    @board.each do |index, col|
      index > 9 ? (print "#{index}|") : (print "#{index} |")
      col.each do |row, cell|
        if reveal == true
          print cell.state.to_s + "|"
        else
          if cell.flag == true
            print "F" + "|"
          elsif cell.reveal == false 
            print "_" + "|"
          else
            print cell.state.to_s + "|"
          end
        end
      end
      puts
    end
    puts "count: #{@count}, flags: #{@flags_nb}"
  end

  def check_move input
    if valid_move? input
      if input[2] == "C"
        make_move input
      else
        if @board[input[0]][input[1]].flag 
          @board[input[0]][input[1]].flag = false
          @flags_nb += 1
        else
          @board[input[0]][input[1]].flag = true
          @flags_nb -= 1
        end
      end
    end
  end

  def check_game_over
    if @count == 0
      puts "You Win !"
      @game_over = true
    end
  end

  def valid_move? input
    if input[0] == "Q"
      @game_over = true
      return false
    end
    return true if @board[input[0]][input[1]].reveal == false
    puts "cannot make this move"
  end

  def make_move input
    if @board[input[0]][input[1]].state == "B"
      puts "It was a Bomb !"
      render_board true
      @game_over = true

    elsif @board[input[0]][input[1]].state > 0
      @board[input[0]][input[1]].reveal = true
      @count -= 1
    else
      col, row = input[0], input[1]
      check_around col, row
    end
  end

  def check_around col, row
    
    if @board[col][row].state > 0 && @board[col][row].reveal == false
      @board[col][row].reveal = true
      @count -= 1
    elsif @board[col][row].reveal == false

      @board[col][row].reveal = true
      @count -= 1

      if col > 1 
        check_around col-1, row
      end
      if col < @board_size
        check_around col+1, row
      end
      if row > 1
        check_around col, row-1
      end
      if row < @board_size
        check_around col, row+1
      end
      if col > 1 && row > 1
        check_around col-1, row-1
      end
      if col > 1 && row < @board_size
        check_around col-1, row+1
      end
      if col < @board_size && row > 1
        check_around col+1, row-1
      end
      if col < @board_size && row < @board_size
        check_around col+1, row+1
      end
    end
  end

end