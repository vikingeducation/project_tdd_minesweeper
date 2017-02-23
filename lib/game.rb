class Game
  attr_accessor :app_state

  def initialize
    @app_state = {
      board: Array.new(10){ Array.new(10) },
      mines: 9,
      flags_remaining: 9
    }
  end

  # ----------------------------------------------------------------------
  # app state
  # ----------------------------------------------------------------------

  def board
    app_state[:board]
  end

  def mines
    app_state[:mines]
  end

  def flags_remaining
    app_state[:flags_remaining]
  end

  def generate_mines
    rows, cols = board.length, board[0].length
    (0...mines).reduce([]) do |acc, i|
      x, y = rand(0...rows), rand(0...cols)
      acc << [x, y]
    end
  end

  def plant_mines!(mine_positions)
    mine_positions.each do |x, y|
      board[x][y] = :B
    end
  end

  def render(msgs)
    # we preppend a \n for aesthetic reaons
    if msgs.is_a?(Array)
      msgs.each_with_index do |msg, i|
        puts if i == 0
        puts msg
      end
    else
      puts "\n#{msgs}"
    end
  end

  def render_board
    puts
    puts "Remaining flags: #{flags_remaining}"
    puts
    board.each_with_index do |row, i|
      # compensating spacing for two digit integer
      i+1 >= 10 ? print("#{i+1} ") : print("#{i+1}  ")
      row.each do |cell|
        case cell
          when nil
            print " - "
          when :B
            print "   "
          when :F
            print " F "
          when :C
            print "   "
        end
      end
      puts
    end
    print "   "
    cols = board[0].length
    (1..cols).each{ |i| print " #{i} " }
  end

  def clear_square!(x, y)
    board[x][y] = :C
  end

  def place_flag!(x, y)
    if flags_remaining > 0 && (board[x][y].nil? || board[x][y] == :B)
      app_state[:flags_remaining] -= 1
      board[x][y] = :F
    else
      false
    end
  end

  def game_loop
  end

  def instructions
    info = [
      "**** MineSweep ****",
      "Welcome to MineSweep",
      "On each turn choose the action and the axis you'd like to perform it on",
      "Valid actions are:",
      "Clear the square: c",
      "Flag a square: f",
      "You should provide first the action, followed by the x and y axis",
      "in the following form:",
      "c, 5, 5",
      "Have fun"
    ]
    render(info)
  end

  def play
    instructions
    game_loop
  end

end
